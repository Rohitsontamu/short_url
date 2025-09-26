# Route handlers for the short URL application

from flask import Flask, request, redirect, render_template, jsonify, url_for
from urllib.parse import urlparse
import re
from db.queries import URLQueries
from middlewares.rate_limiter import RateLimiter
from middlewares.logger import setup_logger

app = Flask(__name__, template_folder='../web')
queries = URLQueries()
rate_limiter = RateLimiter()
logger = setup_logger()


def is_valid_url(url: str) -> bool:
    """Validate if the provided string is a valid URL"""
    try:
        result = urlparse(url)
        return all([result.scheme, result.netloc])
    except:
        return False


@app.route('/')
def index():
    """Home page"""
    return render_template('index.html')


@app.route('/shorten', methods=['GET', 'POST'])
def shorten_url():
    """Create a short URL"""
    if request.method == 'GET':
        return render_template('shorturl.html')
    
    # Rate limiting
    client_ip = request.environ.get('HTTP_X_FORWARDED_FOR', request.remote_addr)
    if not rate_limiter.is_allowed(client_ip):
        logger.warning(f"Rate limit exceeded for IP: {client_ip}")
        return jsonify({'error': 'Rate limit exceeded. Please try again later.'}), 429
    
    data = request.get_json() if request.is_json else request.form
    original_url = data.get('url', '').strip()
    expires_hours = data.get('expires_hours')
    
    if not original_url:
        return render_template('EnterValidUrl.html'), 400
    
    # Add protocol if missing
    if not original_url.startswith(('http://', 'https://')):
        original_url = 'http://' + original_url
    
    if not is_valid_url(original_url):
        return render_template('EnterValidUrl.html'), 400
    
    try:
        expires_hours = int(expires_hours) if expires_hours else None
        if expires_hours and expires_hours <= 0:
            expires_hours = None
    except (ValueError, TypeError):
        expires_hours = None
    
    try:
        short_code = queries.create_short_url(original_url, expires_hours)
        short_url = request.url_root + short_code
        
        logger.info(f"Created short URL: {short_code} for {original_url}")
        
        if request.is_json:
            return jsonify({
                'short_url': short_url,
                'short_code': short_code,
                'original_url': original_url
            })
        else:
            return render_template('shorturl.html', 
                                 short_url=short_url, 
                                 original_url=original_url)
    
    except Exception as e:
        logger.error(f"Error creating short URL: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500


@app.route('/<short_code>')
def redirect_to_original(short_code):
    """Redirect to the original URL"""
    if not re.match(r'^[a-zA-Z0-9]{6}$', short_code):
        return render_template('invalidId.html'), 404
    
    try:
        original_url = queries.get_original_url(short_code)
        
        if not original_url:
            return render_template('invalidOrExpired.html'), 404
        
        # Track the click
        client_ip = request.environ.get('HTTP_X_FORWARDED_FOR', request.remote_addr)
        user_agent = request.headers.get('User-Agent', '')
        queries.track_click(short_code, client_ip, user_agent)
        
        logger.info(f"Redirecting {short_code} to {original_url}")
        return redirect(original_url)
    
    except Exception as e:
        logger.error(f"Error redirecting {short_code}: {str(e)}")
        return render_template('invalidOrExpired.html'), 500


@app.route('/stats/<short_code>')
def get_stats(short_code):
    """Get statistics for a short URL"""
    if not re.match(r'^[a-zA-Z0-9]{6}$', short_code):
        return jsonify({'error': 'Invalid short code'}), 404
    
    try:
        stats = queries.get_url_stats(short_code)
        
        if not stats:
            return jsonify({'error': 'Short URL not found'}), 404
        
        return jsonify(stats)
    
    except Exception as e:
        logger.error(f"Error getting stats for {short_code}: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500


@app.route('/api/urls')
def list_urls():
    """Get all URLs (for admin/debug purposes)"""
    try:
        urls = queries.get_all_urls(limit=50)
        return jsonify(urls)
    except Exception as e:
        logger.error(f"Error listing URLs: {str(e)}")
        return jsonify({'error': 'Internal server error'}), 500


@app.errorhandler(404)
def not_found(error):
    return render_template('invalidId.html'), 404


@app.errorhandler(500)
def internal_error(error):
    return jsonify({'error': 'Internal server error'}), 500


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)