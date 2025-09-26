#!/bin/bash#!/bin/bash#!/bin/bash#!/bin/bash#!/bin/bash#!/bin/bash#!/bin/bash#!/bin/bash#!/bin/bash#!/bin/bash#!/bin/bash

yum update -y

yum install -y python3 python3-pipyum update -y

pip3 install Flask

mkdir -p /home/ec2-user/appyum install -y python3 python3-pipyum update -y

cd /home/ec2-user/app



cat > main.py << 'EOF'

from flask import Flask, request, redirect# Install Flaskyum install -y python3 python3-pipyum update -y

import random, string

app = Flask(__name__)pip3 install Flask

urls = {}

pip3 install Flask

@app.route('/')

def home():# Create directory and Flask app

    return '<h1>URL Shortener</h1><form action="/shorten" method="POST"><input type="url" name="url" placeholder="Enter URL" required><button>Shorten</button></form>'

mkdir -p /home/ec2-user/short-urlyum install -y python3 python3-pipyum update -y && yum install -y python3 python3-pip

@app.route('/shorten', methods=['POST'])

def shorten():cd /home/ec2-user/short-url

    url = request.form['url']

    if not url.startswith(('http://', 'https://')):mkdir -p /home/ec2-user/app

        url = 'http://' + url

    code = ''.join(random.choices(string.ascii_letters + string.digits, k=6))cat > app.py << 'EOF'

    urls[code] = url

    short_url = request.url_root + codefrom flask import Flask, request, redirectcd /home/ec2-user/app

    return f'<h1>Success!</h1><p>Original: {url}</p><p>Short: <a href="{short_url}">{short_url}</a></p><a href="/">Back</a>'

import random

@app.route('/<code>')

def redirect_url(code):import string

    return redirect(urls.get(code, '/'))



if __name__ == '__main__':

    app.run(host='0.0.0.0', port=5000)app = Flask(__name__)cat > app.py << 'EOF'# Create app directorypip3 install Flaskyum update -y && yum install -y python3 python3-pip

EOF

urls = {}

chown -R ec2-user:ec2-user /home/ec2-user/app

su - ec2-user -c "cd /home/ec2-user/app && python3 main.py" &from flask import Flask, request, redirect

def generate_short_code():

    return ''.join(random.choices(string.ascii_letters + string.digits, k=6))import random, stringmkdir -p /home/ec2-user/short-url



@app.route('/')app = Flask(__name__)

def home():

    return '''urls = {}cd /home/ec2-user/short-urlcd /home/ec2-user

    <!DOCTYPE html>

    <html>@app.route('/')

    <head><title>URL Shortener</title></head>

    <body>def home():

        <h1>URL Shortener</h1>

        <form action="/shorten" method="POST">    return '<form action="/s" method="post"><input name="url" placeholder="Enter URL" required><button>Shorten</button></form>'

            <input type="url" name="url" placeholder="Enter your URL" required>

            <button type="submit">Shorten</button>@app.route('/s', methods=['POST'])# Create simple Flask appcd /home/ec2-user && pip3 install Flaskyum update -y && yum install -y python3 python3-pip

        </form>

    </body>def shorten():

    </html>

    '''    u = request.form['url']cat > app.py << 'EOF'



@app.route('/shorten', methods=['POST'])    c = ''.join(random.choices(string.ascii_letters+string.digits, k=4))

def shorten():

    original_url = request.form.get('url')    urls[c] = ufrom flask import Flask, request, redirectcat > app.py << 'EOF'

    if not original_url.startswith(('http://', 'https://')):

        original_url = 'http://' + original_url    return f'<a href="/{c}">{request.host_url}{c}</a><br><a href="/">Back</a>'

    

    short_code = generate_short_code()@app.route('/<c>')import random, string

    urls[short_code] = original_url

    def r(c):

    short_url = f"{request.url_root}{short_code}"

        return redirect(urls.get(c, '/'))from flask import Flask, request, redirect

    return f'''

    <!DOCTYPE html>app.run(host='0.0.0.0', port=5000)

    <html>

    <head><title>URL Shortened</title></head>EOFapp = Flask(__name__)

    <body>

        <h1>Success!</h1>

        <p>Original URL: {original_url}</p>

        <p>Short URL: <a href="{short_url}">{short_url}</a></p>chown -R ec2-user:ec2-user /home/ec2-user/appurls = {}import sqlite3, random, string

        <a href="/">Shorten another URL</a>

    </body>su - ec2-user -c "cd /home/ec2-user/app && nohup python3 app.py &"

    </html>

    '''

def gen_code():app = Flask(__name__)cat > app.py << 'EOF'cd /home/ec2-user && pip3 install Flaskyum update -y && yum install -y python3 python3-pip

@app.route('/<short_code>')

def redirect_to_url(short_code):    return ''.join(random.choices(string.ascii_letters + string.digits, k=6))

    original_url = urls.get(short_code)

    if original_url:

        return redirect(original_url)

    else:@app.route('/')

        return "URL not found", 404

def home():@app.before_first_requestfrom flask import Flask, request, redirect

if __name__ == '__main__':

    app.run(host='0.0.0.0', port=5000, debug=True)    return '''

EOF

    <form action="/shorten" method="POST">def init():

# Change ownership and start the app

chown -R ec2-user:ec2-user /home/ec2-user/short-url        <input type="url" name="url" placeholder="Enter URL" required>

su - ec2-user -c "cd /home/ec2-user/short-url && nohup python3 app.py > app.log 2>&1 &"
        <button type="submit">Shorten</button>    conn = sqlite3.connect('urls.db')import sqlite3, string, random

    </form>

    '''    conn.execute('CREATE TABLE IF NOT EXISTS urls (url TEXT, code TEXT)')



@app.route('/shorten', methods=['POST'])    conn.commit(); conn.close()app = Flask(__name__)

def shorten():

    url = request.form.get('url')

    code = gen_code()

    urls[code] = url@app.route('/')cat > app.py << 'EOF'mkdir -p /home/ec2-user/short-url && cd /home/ec2-user/short-urlyum update -y && yum install -y python3 python3-pip

    return f'''

    <p>Short URL: <a href="/{code}">{request.host_url}{code}</a></p>def home():

    <a href="/">Back</a>

    '''    return '<form action=/s method=POST><input name=url placeholder="Enter URL"><button>Shorten</button></form>'@app.before_first_request



@app.route('/<code>')

def redirect_url(code):

    return redirect(urls.get(code, '/'))@app.route('/s', methods=['POST'])def init():from flask import Flask, request, redirect



if __name__ == '__main__':def shorten():

    app.run(host='0.0.0.0', port=5000)

EOF    url = request.form['url']    conn = sqlite3.connect('urls.db')



# Install Flask    if not url.startswith('http'): url = 'http://' + url

pip3 install Flask

    code = ''.join(random.choices(string.ascii_letters, k=6))    conn.execute('CREATE TABLE IF NOT EXISTS urls (url TEXT, code TEXT)')import sqlite3, string, randompip3 install Flask

# Change ownership

chown -R ec2-user:ec2-user /home/ec2-user/short-url    conn = sqlite3.connect('urls.db')



# Start app    conn.execute('INSERT INTO urls VALUES (?, ?)', (url, code))    conn.commit(); conn.close()

nohup python3 app.py > /var/log/short-url.log 2>&1 &
    conn.commit(); conn.close()

    return f'Short URL: {request.url_root}{code}'



@app.route('/<code>')@app.route('/')

def go(code):

    conn = sqlite3.connect('urls.db')def home():app = Flask(__name__)mkdir -p /home/ec2-user/short-url && cd /home/ec2-user/short-url# Compact setup for Short URL app with your UI design# Simplified setup script for Short URL app

    result = conn.execute('SELECT url FROM urls WHERE code=?', (code,)).fetchone()

    conn.close()    return '<html><body style="text-align:center;padding:50px"><h1>Short URL</h1><form action="/s" method="POST"><input name="url" placeholder="Enter URL" style="padding:10px;width:300px"><br><br><button style="padding:10px 20px;background:blue;color:white;border:none">Shorten</button></form></body></html>'

    return redirect(result[0]) if result else 'Not found'



if __name__ == '__main__': app.run(host='0.0.0.0', port=5000)

EOF@app.route('/s', methods=['POST'])



chown ec2-user:ec2-user app.pydef shorten():def init(): cat > app.py << 'EOF'

python3 app.py &
    url = request.form['url']

    if not url.startswith('http'): url = 'http://' + url    conn = sqlite3.connect('urls.db')

    code = ''.join(random.choices(string.ascii_letters, k=6))

    conn = sqlite3.connect('urls.db')    conn.execute('CREATE TABLE IF NOT EXISTS urls (id INTEGER PRIMARY KEY, url TEXT, code TEXT)')from flask import Flask, request, redirect, jsonifypip3 install Flask

    conn.execute('INSERT INTO urls VALUES (?, ?)', (url, code))

    conn.commit(); conn.close()    conn.commit(); conn.close()

    return f'<html><body style="text-align:center;padding:50px"><h2>Success!</h2><p>Short URL: <b>{request.url_root}{code}</b></p><a href="/">Back</a></body></html>'

import sqlite3, string, random, os

@app.route('/<code>')

def go(code):def gen(): return ''.join(random.choices(string.ascii_letters + string.digits, k=6))

    conn = sqlite3.connect('urls.db')

    result = conn.execute('SELECT url FROM urls WHERE code=?', (code,)).fetchone()from urllib.parse import urlparseyum update -y && yum install -y python3 python3-pipyum update -y

    conn.close()

    return redirect(result[0]) if result else 'Not found'@app.before_first_request



@app.route('/health')def setup(): init()

def health(): return 'OK'



if __name__ == '__main__': app.run(host='0.0.0.0', port=5000)

EOF@app.route('/')app = Flask(__name__)cat > app.py << 'PYEOF'



chown ec2-user:ec2-user app.pydef home():



cat > /etc/systemd/system/short-url.service << 'EOF'    return '''<html><head><title>Short URL</title><style>body{font-family:Arial;text-align:center;padding:50px;background:#f0f0f0}h1{color:#333}.input{padding:10px;margin:10px;border:1px solid #ccc;border-radius:5px;width:300px}.btn{padding:10px 20px;background:#007bff;color:white;border:none;border-radius:5px;cursor:pointer}</style></head><body><h1>🔗 Short URL</h1><form action="/s" method="POST"><input class="input" name="url" placeholder="Enter URL..." required><br><button class="btn">Shorten</button></form></body></html>'''DB = '/home/ec2-user/short-url/urls.db'

[Unit]

Description=Short URL App

[Service]

User=ec2-user@app.route('/s', methods=['POST'])from flask import Flask, request, redirect, jsonifymkdir -p /home/ec2-user/short-url && cd /home/ec2-user/short-urlyum install -y python3 python3-pip git

WorkingDirectory=/home/ec2-user

ExecStart=/usr/bin/python3 app.pydef shorten():

Restart=always

EOF    url = request.form['url']def init_db():



systemctl enable short-url && systemctl start short-url    if not url.startswith('http'): url = 'http://' + url

    conn = sqlite3.connect('urls.db')    os.makedirs(os.path.dirname(DB), exist_ok=True)import sqlite3, string, random, os

    code = gen()

    conn.execute('INSERT INTO urls (url, code) VALUES (?, ?)', (url, code))    conn = sqlite3.connect(DB)

    conn.commit(); conn.close()

    return f'<html><body style="font-family:Arial;text-align:center;padding:50px"><h2>✅ Success!</h2><p>Short URL: <b>{request.url_root}{code}</b></p><a href="/">← Back</a></body></html>'    conn.execute('CREATE TABLE IF NOT EXISTS urls (id INTEGER PRIMARY KEY, original_url TEXT, short_code TEXT UNIQUE, click_count INTEGER DEFAULT 0)')from urllib.parse import urlparsepip3 install Flask



@app.route('/<code>')    conn.commit(); conn.close()

def go(code):

    conn = sqlite3.connect('urls.db')

    result = conn.execute('SELECT url FROM urls WHERE code=?', (code,)).fetchone()

    conn.close()def get_db(): return sqlite3.connect(DB)

    return redirect(result[0]) if result else 'Not found'

def gen_code(): return ''.join(random.choices(string.ascii_letters + string.digits, k=6))app = Flask(__name__)# Create project directory and basic structure

@app.route('/health')

def health(): return 'OK'def valid_url(url): 



if __name__ == '__main__': app.run(host='0.0.0.0', port=5000)    try: return all(urlparse(url)[i] for i in [0,1])DB = '/home/ec2-user/short-url/urls.db'

EOF

    except: return False

chown ec2-user:ec2-user app.py

cat > app.py << 'EOF'mkdir -p /home/ec2-user/short-url/{handlers,web,middlewares,db,logs}

cat > /etc/systemd/system/short-url.service << 'EOF'

[Unit]@app.before_first_request

Description=Short URL App

[Service]def setup(): init_db()def init_db():

User=ec2-user

WorkingDirectory=/home/ec2-user

ExecStart=/usr/bin/python3 app.py

Restart=always@app.route('/')    os.makedirs(os.path.dirname(DB), exist_ok=True)from flask import Flask, request, redirect, jsonifycd /home/ec2-user/short-url

EOF

def home():

systemctl enable short-url && systemctl start short-url
    return '''<!DOCTYPE html><html><head><title>Short URL</title><style>*{margin:0;padding:0;box-sizing:border-box}body{font-family:'Segoe UI',sans-serif;background:linear-gradient(135deg,#667eea,#764ba2);min-height:100vh;display:flex;align-items:center;justify-content:center}.container{background:white;padding:40px;border-radius:20px;box-shadow:0 20px 40px rgba(0,0,0,0.1);text-align:center;max-width:500px;width:90%}.logo{font-size:3rem;margin-bottom:10px}h1{color:#333;margin-bottom:10px;font-size:2.5rem;font-weight:300}.tagline{color:#666;margin-bottom:40px;font-size:1.1rem}.url-input{width:100%;padding:18px 25px;border:2px solid #e0e0e0;border-radius:50px;font-size:16px;outline:none;background:#f8f9fa;margin-bottom:20px}.url-input:focus{border-color:#667eea;background:white;box-shadow:0 0 0 4px rgba(102,126,234,0.1)}.shorten-btn{background:linear-gradient(135deg,#667eea,#764ba2);color:white;border:none;padding:18px 40px;border-radius:50px;font-size:16px;font-weight:600;cursor:pointer;width:100%;text-transform:uppercase;letter-spacing:1px}.shorten-btn:hover{transform:translateY(-2px);box-shadow:0 10px 25px rgba(102,126,234,0.3)}.features{display:grid;grid-template-columns:repeat(auto-fit,minmax(140px,1fr));gap:20px;margin-top:40px;padding-top:30px;border-top:1px solid #e0e0e0}.feature{text-align:center}.feature-icon{font-size:2rem;margin-bottom:10px}.feature-text{color:#666;font-size:0.9rem}</style></head><body><div class="container"><div class="logo">🔗</div><h1>Short URL</h1><p class="tagline">Transform long URLs into short, shareable links</p><form action="/shorten" method="POST"><input type="url" name="url" class="url-input" placeholder="Enter your long URL here..." required><button type="submit" class="shorten-btn">Shorten URL</button></form><div class="features"><div class="feature"><div class="feature-icon">⚡</div><div class="feature-text">Lightning Fast</div></div><div class="feature"><div class="feature-icon">📊</div><div class="feature-text">Click Analytics</div></div><div class="feature"><div class="feature-icon">⏰</div><div class="feature-text">Custom Expiry</div></div></div></div></body></html>'''    conn = sqlite3.connect(DB)



@app.route('/shorten', methods=['POST'])    conn.execute('CREATE TABLE IF NOT EXISTS urls (id INTEGER PRIMARY KEY, original_url TEXT, short_code TEXT UNIQUE, click_count INTEGER DEFAULT 0)')from urllib.parse import urlparse

def shorten():

    url = request.form.get('url', '').strip()    conn.commit(); conn.close()

    if not url.startswith(('http://', 'https://')): url = 'http://' + url

    if not valid_url(url): return "Invalid URL", 400import sqlite3, string, random, os# Create requirements.txt

    

    conn = get_db()def get_db(): return sqlite3.connect(DB)

    while True:

        code = gen_code()def gen_code(): return ''.join(random.choices(string.ascii_letters + string.digits, k=6))from datetime import datetime, timedeltaecho "Flask==3.0.0" > requirements.txt

        if not conn.execute('SELECT 1 FROM urls WHERE short_code=?', (code,)).fetchone(): break

    def valid_url(url): 

    conn.execute('INSERT INTO urls (original_url, short_code) VALUES (?, ?)', (url, code))

    conn.commit(); conn.close()    try: return all(urlparse(url)[i] for i in [0,1])echo "python-dotenv==1.0.0" >> requirements.txt

    short_url = request.url_root + code

        except: return False

    return f'<!DOCTYPE html><html><head><title>Success!</title><style>body{{font-family:"Segoe UI",sans-serif;background:linear-gradient(135deg,#667eea,#764ba2);min-height:100vh;display:flex;align-items:center;justify-content:center}}.container{{background:white;padding:40px;border-radius:20px;text-align:center;max-width:600px;width:90%}}.success-icon{{font-size:4rem;color:#28a745;margin-bottom:20px}}h1{{color:#28a745;margin-bottom:30px;font-size:2.5rem}}.url-result{{background:#f8f9fa;padding:20px;border-radius:15px;margin:20px 0;border-left:4px solid #28a745}}.url-label{{font-weight:600;color:#333;margin-bottom:8px}}.url-value{{font-family:monospace;background:white;padding:12px;border-radius:8px;border:1px solid #e0e0e0;word-break:break-all;color:#007bff}}.back-link{{display:inline-block;margin-top:30px;color:#667eea;text-decoration:none;font-weight:600}}</style></head><body><div class="container"><div class="success-icon">✅</div><h1>Success!</h1><div class="url-result"><div class="url-label">Original URL:</div><div class="url-value">{url}</div></div><div class="url-result"><div class="url-label">Short URL:</div><div class="url-value">{short_url}</div></div><a href="/" class="back-link">← Shorten another URL</a></div></body></html>'

app = Flask(__name__)

@app.route('/<code>')

def redirect_url(code):@app.before_first_request

    conn = get_db()

    result = conn.execute('SELECT original_url FROM urls WHERE short_code=?', (code,)).fetchone()def setup(): init_db()DATABASE = '/home/ec2-user/short-url/urls.db'# Download project files from your repository or create minimal versions

    if result:

        conn.execute('UPDATE urls SET click_count=click_count+1 WHERE short_code=?', (code,))

        conn.commit()

    conn.close()@app.route('/')pip3 install Flask python-dotenv

    return redirect(result[0]) if result else ("URL not found", 404)

def home():

@app.route('/health')

def health(): return jsonify({"status": "healthy", "service": "short-url"})    return '''<!DOCTYPE html><html><head><title>Short URL</title><style>*{margin:0;padding:0;box-sizing:border-box}body{font-family:'Segoe UI',sans-serif;background:linear-gradient(135deg,#667eea,#764ba2);min-height:100vh;display:flex;align-items:center;justify-content:center}.container{background:white;padding:40px;border-radius:20px;box-shadow:0 20px 40px rgba(0,0,0,0.1);text-align:center;max-width:500px;width:90%}.logo{font-size:3rem;margin-bottom:10px}h1{color:#333;margin-bottom:10px;font-size:2.5rem;font-weight:300}.tagline{color:#666;margin-bottom:40px;font-size:1.1rem}.url-input{width:100%;padding:18px 25px;border:2px solid #e0e0e0;border-radius:50px;font-size:16px;outline:none;background:#f8f9fa;margin-bottom:20px}.url-input:focus{border-color:#667eea;background:white;box-shadow:0 0 0 4px rgba(102,126,234,0.1)}.shorten-btn{background:linear-gradient(135deg,#667eea,#764ba2);color:white;border:none;padding:18px 40px;border-radius:50px;font-size:16px;font-weight:600;cursor:pointer;width:100%;text-transform:uppercase;letter-spacing:1px}.shorten-btn:hover{transform:translateY(-2px);box-shadow:0 10px 25px rgba(102,126,234,0.3)}.features{display:grid;grid-template-columns:repeat(auto-fit,minmax(140px,1fr));gap:20px;margin-top:40px;padding-top:30px;border-top:1px solid #e0e0e0}.feature{text-align:center}.feature-icon{font-size:2rem;margin-bottom:10px}.feature-text{color:#666;font-size:0.9rem}</style></head><body><div class="container"><div class="logo">🔗</div><h1>Short URL</h1><p class="tagline">Transform long URLs into short, shareable links</p><form action="/shorten" method="POST"><input type="url" name="url" class="url-input" placeholder="Enter your long URL here..." required><button type="submit" class="shorten-btn">Shorten URL</button></form><div class="features"><div class="feature"><div class="feature-icon">⚡</div><div class="feature-text">Lightning Fast</div></div><div class="feature"><div class="feature-icon">📊</div><div class="feature-text">Click Analytics</div></div><div class="feature"><div class="feature-icon">⏰</div><div class="feature-text">Custom Expiry</div></div></div></div></body></html>'''def init_db():



if __name__ == '__main__': app.run(host='0.0.0.0', port=5000)

EOF

@app.route('/shorten', methods=['POST'])    os.makedirs(os.path.dirname(DATABASE), exist_ok=True)# Create main.py (simplified for EC2)

chown -R ec2-user:ec2-user /home/ec2-user/short-url

def shorten():

cat > /etc/systemd/system/short-url.service << 'EOF'

[Unit]    url = request.form.get('url', '').strip()    conn = sqlite3.connect(DATABASE)cat << 'EOF' > main.py

Description=Short URL Flask App

After=network.target    if not url.startswith(('http://', 'https://')): url = 'http://' + url

[Service]

Type=simple    if not valid_url(url): return "Invalid URL", 400    conn.execute('''CREATE TABLE IF NOT EXISTS urls (from handlers.routes import app

User=ec2-user

WorkingDirectory=/home/ec2-user/short-url    

ExecStart=/usr/bin/python3 app.py

Restart=always    conn = get_db()        id INTEGER PRIMARY KEY, original_url TEXT, short_code TEXT UNIQUE,import os

[Install]

WantedBy=multi-user.target    while True:

EOF

        code = gen_code()        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, click_count INTEGER DEFAULT 0)''')

systemctl daemon-reload && systemctl enable short-url.service && systemctl start short-url.service
        if not conn.execute('SELECT 1 FROM urls WHERE short_code=?', (code,)).fetchone(): break

        conn.commit(); conn.close()# Export application for systemd service

    conn.execute('INSERT INTO urls (original_url, short_code) VALUES (?, ?)', (url, code))

    conn.commit(); conn.close()application = app

    short_url = request.url_root + code

    def get_db(): return sqlite3.connect(DATABASE)

    return f'<!DOCTYPE html><html><head><title>Success!</title><style>body{{font-family:"Segoe UI",sans-serif;background:linear-gradient(135deg,#667eea,#764ba2);min-height:100vh;display:flex;align-items:center;justify-content:center}}.container{{background:white;padding:40px;border-radius:20px;text-align:center;max-width:600px;width:90%}}.success-icon{{font-size:4rem;color:#28a745;margin-bottom:20px}}h1{{color:#28a745;margin-bottom:30px;font-size:2.5rem}}.url-result{{background:#f8f9fa;padding:20px;border-radius:15px;margin:20px 0;border-left:4px solid #28a745}}.url-label{{font-weight:600;color:#333;margin-bottom:8px}}.url-value{{font-family:monospace;background:white;padding:12px;border-radius:8px;border:1px solid #e0e0e0;word-break:break-all;color:#007bff}}.back-link{{display:inline-block;margin-top:30px;color:#667eea;text-decoration:none;font-weight:600}}</style></head><body><div class="container"><div class="success-icon">✅</div><h1>Success!</h1><div class="url-result"><div class="url-label">Original URL:</div><div class="url-value">{url}</div></div><div class="url-result"><div class="url-label">Short URL:</div><div class="url-value">{short_url}</div></div><a href="/" class="back-link">← Shorten another URL</a></div></body></html>'

def gen_code(): return ''.join(random.choices(string.ascii_letters + string.digits, k=6))if __name__ == "__main__":

@app.route('/<code>')

def redirect_url(code):def valid_url(url):     port = int(os.environ.get("PORT", 5000))

    conn = get_db()

    result = conn.execute('SELECT original_url FROM urls WHERE short_code=?', (code,)).fetchone()    try: return all(urlparse(url)[i] for i in [0,1])    app.run(host="0.0.0.0", port=port, debug=False)

    if result:

        conn.execute('UPDATE urls SET click_count=click_count+1 WHERE short_code=?', (code,))    except: return FalseEOF

        conn.commit()

    conn.close()

    return redirect(result[0]) if result else ("URL not found", 404)

@app.before_first_request# Create app.py for systemd service

@app.route('/health')

def health(): return jsonify({"status": "healthy", "service": "short-url"})def setup(): init_db()cat << 'EOF' > app.py



if __name__ == '__main__': app.run(host='0.0.0.0', port=5000)from handlers.routes import app

PYEOF

@app.route('/')import os

chown -R ec2-user:ec2-user /home/ec2-user/short-url

def home():

cat > /etc/systemd/system/short-url.service << 'SVCEOF'

[Unit]    return '''<!DOCTYPE html><html><head><title>Short URL</title><style>*{margin:0;padding:0;box-sizing:border-box}body{font-family:'Segoe UI',sans-serif;background:linear-gradient(135deg,#667eea,#764ba2);min-height:100vh;display:flex;align-items:center;justify-content:center}.container{background:white;padding:40px;border-radius:20px;box-shadow:0 20px 40px rgba(0,0,0,0.1);text-align:center;max-width:500px;width:90%}.logo{font-size:3rem;margin-bottom:10px}h1{color:#333;margin-bottom:10px;font-size:2.5rem;font-weight:300}.tagline{color:#666;margin-bottom:40px;font-size:1.1rem}.url-input{width:100%;padding:18px 25px;border:2px solid #e0e0e0;border-radius:50px;font-size:16px;outline:none;background:#f8f9fa;margin-bottom:20px}.url-input:focus{border-color:#667eea;background:white;box-shadow:0 0 0 4px rgba(102,126,234,0.1)}.shorten-btn{background:linear-gradient(135deg,#667eea,#764ba2);color:white;border:none;padding:18px 40px;border-radius:50px;font-size:16px;font-weight:600;cursor:pointer;width:100%;text-transform:uppercase;letter-spacing:1px}.shorten-btn:hover{transform:translateY(-2px);box-shadow:0 10px 25px rgba(102,126,234,0.3)}.features{display:grid;grid-template-columns:repeat(auto-fit,minmax(140px,1fr));gap:20px;margin-top:40px;padding-top:30px;border-top:1px solid #e0e0e0}.feature{text-align:center}.feature-icon{font-size:2rem;margin-bottom:10px}.feature-text{color:#666;font-size:0.9rem}</style></head><body><div class="container"><div class="logo">🔗</div><h1>Short URL</h1><p class="tagline">Transform long URLs into short, shareable links</p><form action="/shorten" method="POST"><input type="url" name="url" class="url-input" placeholder="Enter your long URL here..." required><button type="submit" class="shorten-btn">Shorten URL</button></form><div class="features"><div class="feature"><div class="feature-icon">⚡</div><div class="feature-text">Lightning Fast</div></div><div class="feature"><div class="feature-icon">📊</div><div class="feature-text">Click Analytics</div></div><div class="feature"><div class="feature-icon">⏰</div><div class="feature-text">Custom Expiry</div></div></div></div></body></html>'''if __name__ == "__main__":

Description=Short URL Flask App

After=network.target    port = int(os.environ.get("PORT", 5000))

[Service]

Type=simple@app.route('/shorten', methods=['POST'])    app.run(host="0.0.0.0", port=port, debug=False)

User=ec2-user

WorkingDirectory=/home/ec2-user/short-urldef shorten():EOF

ExecStart=/usr/bin/python3 app.py

Restart=always    url = request.form.get('url', '').strip()

[Install]

WantedBy=multi-user.target    if not url.startswith(('http://', 'https://')): url = 'http://' + url# Create the handlers directory and routes.py

SVCEOF

    if not valid_url(url): return "Invalid URL", 400cat << 'EOF' > handlers/__init__.py

systemctl daemon-reload && systemctl enable short-url.service && systemctl start short-url.service
    # handlers package

    conn = get_db()EOF

    while True:

        code = gen_code()cat << 'EOF' > handlers/routes.py

        if not conn.execute('SELECT 1 FROM urls WHERE short_code=?', (code,)).fetchone(): breakfrom flask import Flask, request, redirect, render_template, jsonify, url_for

    from urllib.parse import urlparse

    conn.execute('INSERT INTO urls (original_url, short_code) VALUES (?, ?)', (url, code))import sqlite3

    conn.commit(); conn.close()import string

    short_url = request.url_root + codeimport random

    import os

    return f'''<!DOCTYPE html><html><head><title>Success!</title><style>body{{font-family:'Segoe UI',sans-serif;background:linear-gradient(135deg,#667eea,#764ba2);min-height:100vh;display:flex;align-items:center;justify-content:center}}.container{{background:white;padding:40px;border-radius:20px;text-align:center;max-width:600px;width:90%}}.success-icon{{font-size:4rem;color:#28a745;margin-bottom:20px}}h1{{color:#28a745;margin-bottom:30px;font-size:2.5rem}}.url-result{{background:#f8f9fa;padding:20px;border-radius:15px;margin:20px 0;border-left:4px solid #28a745}}.url-label{{font-weight:600;color:#333;margin-bottom:8px}}.url-value{{font-family:monospace;background:white;padding:12px;border-radius:8px;border:1px solid #e0e0e0;word-break:break-all;color:#007bff}}.back-link{{display:inline-block;margin-top:30px;color:#667eea;text-decoration:none;font-weight:600}}</style></head><body><div class="container"><div class="success-icon">✅</div><h1>Success!</h1><div class="url-result"><div class="url-label">Original URL:</div><div class="url-value">{url}</div></div><div class="url-result"><div class="url-label">Short URL:</div><div class="url-value">{short_url}</div></div><a href="/" class="back-link">← Shorten another URL</a></div></body></html>'''from datetime import datetime, timedelta



@app.route('/<code>')app = Flask(__name__, template_folder='../web')

def redirect_url(code):

    conn = get_db()# Database setup

    result = conn.execute('SELECT original_url FROM urls WHERE short_code=?', (code,)).fetchone()DATABASE = '/home/ec2-user/short-url/db/urls.db'

    if result:

        conn.execute('UPDATE urls SET click_count=click_count+1 WHERE short_code=?', (code,))def init_db():

        conn.commit()    """Initialize the database with the required table."""

    conn.close()    os.makedirs(os.path.dirname(DATABASE), exist_ok=True)

    return redirect(result[0]) if result else ("URL not found", 404)    conn = sqlite3.connect(DATABASE)

    cursor = conn.cursor()

@app.route('/health')    

def health(): return jsonify({"status": "healthy", "service": "short-url"})    cursor.execute('''

        CREATE TABLE IF NOT EXISTS urls (

if __name__ == '__main__': app.run(host='0.0.0.0', port=5000)            id INTEGER PRIMARY KEY AUTOINCREMENT,

EOF            original_url TEXT NOT NULL,

            short_code TEXT UNIQUE NOT NULL,

chown -R ec2-user:ec2-user /home/ec2-user/short-url            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

            expires_at TIMESTAMP,

cat > /etc/systemd/system/short-url.service << 'EOF'            click_count INTEGER DEFAULT 0

[Unit]        )

Description=Short URL Flask App    ''')

After=network.target    

[Service]    conn.commit()

Type=simple    conn.close()

User=ec2-user

WorkingDirectory=/home/ec2-user/short-urldef generate_short_code(length=6):

ExecStart=/usr/bin/python3 app.py    """Generate a random short code."""

Restart=always    characters = string.ascii_letters + string.digits

[Install]    return ''.join(random.choice(characters) for _ in range(length))

WantedBy=multi-user.target

EOFdef get_db_connection():

    """Get a database connection."""

systemctl daemon-reload && systemctl enable short-url.service && systemctl start short-url.service    conn = sqlite3.connect(DATABASE)
    conn.row_factory = sqlite3.Row
    return conn

def is_valid_url(url: str) -> bool:
    """Validate if the provided string is a valid URL"""
    try:
        result = urlparse(url)
        return all([result.scheme, result.netloc])
    except:
        return False

@app.before_first_request
def create_tables():
    """Create database tables before first request."""
    init_db()

@app.route('/')
def index():
    """Home page"""
    return render_template('index.html')

@app.route('/shorten', methods=['GET', 'POST'])
def shorten_url():
    """Create a short URL"""
    if request.method == 'GET':
        return render_template('shorturl.html')
    
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
    
    # Generate unique short code
    conn = get_db_connection()
    cursor = conn.cursor()
    
    while True:
        short_code = generate_short_code()
        cursor.execute('SELECT id FROM urls WHERE short_code = ?', (short_code,))
        if cursor.fetchone() is None:
            break
    
    # Calculate expiration
    expires_at = None
    if expires_hours:
        try:
            expires_hours = int(expires_hours)
            expires_at = datetime.now() + timedelta(hours=expires_hours)
        except ValueError:
            pass
    
    # Insert into database
    cursor.execute(
        'INSERT INTO urls (original_url, short_code, expires_at) VALUES (?, ?, ?)',
        (original_url, short_code, expires_at)
    )
    conn.commit()
    conn.close()
    
    # Return the shortened URL
    short_url = request.url_root + short_code
    
    if request.is_json:
        return jsonify({
            'success': True,
            'original_url': original_url,
            'short_url': short_url,
            'short_code': short_code,
            'expires_at': expires_at.isoformat() if expires_at else None
        })
    else:
        return render_template('shorturl.html', 
                             original_url=original_url, 
                             short_url=short_url,
                             expires_at=expires_at)

@app.route('/<short_code>')
def redirect_to_url(short_code):
    """Redirect to original URL using short code."""
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Get original URL and check expiration
        cursor.execute(
            'SELECT original_url, expires_at FROM urls WHERE short_code = ?', 
            (short_code,)
        )
        result = cursor.fetchone()
        
        if result:
            original_url = result[0]
            expires_at = result[1]
            
            # Check if expired
            if expires_at:
                expires_dt = datetime.fromisoformat(expires_at)
                if datetime.now() > expires_dt:
                    conn.close()
                    return render_template('invalidOrExpired.html'), 404
            
            # Increment click count
            cursor.execute(
                'UPDATE urls SET click_count = click_count + 1 WHERE short_code = ?',
                (short_code,)
            )
            conn.commit()
            conn.close()
            return redirect(original_url)
        else:
            conn.close()
            return render_template('invalidId.html'), 404
    
    except Exception as e:
        return render_template('invalidId.html'), 500

@app.route('/api/stats/<short_code>')
def get_stats(short_code):
    """Get statistics for a short URL."""
    try:
        conn = get_db_connection()
        cursor = conn.cursor()
        
        cursor.execute(
            'SELECT original_url, created_at, click_count, expires_at FROM urls WHERE short_code = ?',
            (short_code,)
        )
        result = cursor.fetchone()
        conn.close()
        
        if result:
            return jsonify({
                'short_code': short_code,
                'original_url': result[0],
                'created_at': result[1],
                'click_count': result[2],
                'expires_at': result[3]
            })
        else:
            return jsonify({'error': 'Short URL not found'}), 404
    
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/health')
def health_check():
    """Health check endpoint."""
    return jsonify({'status': 'healthy', 'service': 'short-url'}), 200

if __name__ == '__main__':
    app.run(debug=True)
EOF

# Create middlewares directory
cat << 'EOF' > middlewares/__init__.py
# middlewares package
EOF

cat << 'EOF' > middlewares/logger.py
import logging
import os
from datetime import datetime

def setup_logger():
    """Set up logging configuration"""
    log_dir = '/home/ec2-user/short-url/logs'
    os.makedirs(log_dir, exist_ok=True)
    
    logging.basicConfig(
        level=logging.INFO,
        format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
        handlers=[
            logging.FileHandler(f'{log_dir}/app.log'),
            logging.StreamHandler()
        ]
    )
    
    return logging.getLogger(__name__)
EOF

# Create your beautiful index.html
cat << 'EOF' > web/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Short URL - URL Shortener</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .container {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
            width: 90%;
            backdrop-filter: blur(10px);
        }
        
        .logo {
            font-size: 3rem;
            margin-bottom: 10px;
        }
        
        h1 {
            color: #333;
            margin-bottom: 10px;
            font-size: 2.5rem;
            font-weight: 300;
        }
        
        .tagline {
            color: #666;
            margin-bottom: 40px;
            font-size: 1.1rem;
        }
        
        .url-form {
            margin-bottom: 30px;
        }
        
        .input-group {
            position: relative;
            margin-bottom: 20px;
        }
        
        .url-input {
            width: 100%;
            padding: 18px 25px;
            border: 2px solid #e0e0e0;
            border-radius: 50px;
            font-size: 16px;
            outline: none;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }
        
        .url-input:focus {
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }
        
        .expire-group {
            margin-bottom: 25px;
        }
        
        .expire-input {
            width: 150px;
            padding: 12px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 25px;
            font-size: 14px;
            outline: none;
            transition: all 0.3s ease;
            background: #f8f9fa;
        }
        
        .expire-input:focus {
            border-color: #667eea;
            background: white;
        }
        
        .shorten-btn {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 18px 40px;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            width: 100%;
        }
        
        .shorten-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(102, 126, 234, 0.3);
        }
        
        .shorten-btn:active {
            transform: translateY(0);
        }
        
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(140px, 1fr));
            gap: 20px;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 1px solid #e0e0e0;
        }
        
        .feature {
            text-align: center;
        }
        
        .feature-icon {
            font-size: 2rem;
            margin-bottom: 10px;
        }
        
        .feature-text {
            color: #666;
            font-size: 0.9rem;
        }
        
        @media (max-width: 480px) {
            .container {
                padding: 30px 20px;
                margin: 20px;
            }
            
            h1 {
                font-size: 2rem;
            }
            
            .features {
                grid-template-columns: 1fr;
                gap: 15px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="logo">🔗</div>
        <h1>Short URL</h1>
        <p class="tagline">Transform long URLs into short, shareable links</p>
        
        <form class="url-form" action="/shorten" method="POST">
            <div class="input-group">
                <input type="url" name="url" class="url-input" placeholder="Enter your long URL here..." required>
            </div>
            
            <div class="expire-group">
                <label for="expires_hours" style="color: #666; font-size: 14px; margin-right: 10px;">Expires in hours (optional):</label>
                <input type="number" name="expires_hours" class="expire-input" placeholder="24" min="1" max="8760">
            </div>
            
            <button type="submit" class="shorten-btn">Shorten URL</button>
        </form>
        
        <div class="features">
            <div class="feature">
                <div class="feature-icon">⚡</div>
                <div class="feature-text">Lightning Fast</div>
            </div>
            <div class="feature">
                <div class="feature-icon">📊</div>
                <div class="feature-text">Click Analytics</div>
            </div>
            <div class="feature">
                <div class="feature-icon">⏰</div>
                <div class="feature-text">Custom Expiry</div>
            </div>
        </div>
    </div>
</body>
</html>
EOF

# Create other template files
cat << 'EOF' > web/shorturl.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>URL Shortened Successfully!</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .container {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 600px;
            width: 90%;
        }
        
        .success-icon {
            font-size: 4rem;
            color: #28a745;
            margin-bottom: 20px;
        }
        
        h1 {
            color: #28a745;
            margin-bottom: 30px;
            font-size: 2.5rem;
        }
        
        .url-result {
            background: #f8f9fa;
            padding: 20px;
            border-radius: 15px;
            margin: 20px 0;
            border-left: 4px solid #28a745;
        }
        
        .url-label {
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }
        
        .url-value {
            font-family: 'Courier New', monospace;
            background: white;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #e0e0e0;
            word-break: break-all;
            color: #007bff;
        }
        
        .copy-btn {
            background: #007bff;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 25px;
            margin-top: 10px;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .copy-btn:hover {
            background: #0056b3;
            transform: translateY(-1px);
        }
        
        .back-link {
            display: inline-block;
            margin-top: 30px;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .back-link:hover {
            color: #764ba2;
            transform: translateX(-5px);
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-icon">✅</div>
        <h1>Success!</h1>
        
        <div class="url-result">
            <div class="url-label">Original URL:</div>
            <div class="url-value">{{ original_url }}</div>
        </div>
        
        <div class="url-result">
            <div class="url-label">Short URL:</div>
            <div class="url-value" id="shortUrl">{{ short_url }}</div>
            <button class="copy-btn" onclick="copyToClipboard()">📋 Copy</button>
        </div>
        
        {% if expires_at %}
        <div class="url-result">
            <div class="url-label">Expires:</div>
            <div class="url-value">{{ expires_at.strftime('%Y-%m-%d %H:%M:%S') if expires_at else 'Never' }}</div>
        </div>
        {% endif %}
        
        <a href="/" class="back-link">← Shorten another URL</a>
    </div>
    
    <script>
        function copyToClipboard() {
            const shortUrl = document.getElementById('shortUrl').textContent;
            navigator.clipboard.writeText(shortUrl).then(function() {
                const btn = document.querySelector('.copy-btn');
                btn.textContent = '✅ Copied!';
                setTimeout(() => {
                    btn.textContent = '📋 Copy';
                }, 2000);
            });
        }
    </script>
</body>
</html>
EOF

# Create error pages
cat << 'EOF' > web/EnterValidUrl.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invalid URL</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .container {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
            width: 90%;
        }
        
        .error-icon {
            font-size: 4rem;
            color: #dc3545;
            margin-bottom: 20px;
        }
        
        h1 {
            color: #dc3545;
            margin-bottom: 20px;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-icon">⚠️</div>
        <h1>Invalid URL</h1>
        <p>Please enter a valid URL.</p>
        <a href="/" class="back-link">← Go back</a>
    </div>
</body>
</html>
EOF

cat << 'EOF' > web/invalidId.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>URL Not Found</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .container {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
            width: 90%;
        }
        
        .error-icon {
            font-size: 4rem;
            color: #dc3545;
            margin-bottom: 20px;
        }
        
        h1 {
            color: #dc3545;
            margin-bottom: 20px;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-icon">🔍</div>
        <h1>URL Not Found</h1>
        <p>The short URL you're looking for doesn't exist or may have been removed.</p>
        <a href="/" class="back-link">← Create a new short URL</a>
    </div>
</body>
</html>
EOF

cat << 'EOF' > web/invalidOrExpired.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>URL Expired</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .container {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
            width: 90%;
        }
        
        .error-icon {
            font-size: 4rem;
            color: #ffc107;
            margin-bottom: 20px;
        }
        
        h1 {
            color: #ffc107;
            margin-bottom: 20px;
        }
        
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="error-icon">⏰</div>
        <h1>URL Expired</h1>
        <p>This short URL has expired and is no longer available.</p>
        <a href="/" class="back-link">← Create a new short URL</a>
    </div>
</body>
</html>
EOF

# Install Python dependencies
pip3 install Flask python-dotenv

# Change ownership to ec2-user
chown -R ec2-user:ec2-user /home/ec2-user/short-url

# Create systemd service
cat << 'EOF' > /etc/systemd/system/short-url.service
[Unit]
Description=Short URL Flask Application
After=network.target

[Service]
Type=simple
User=ec2-user
WorkingDirectory=/home/ec2-user/short-url
ExecStart=/usr/bin/python3 app.py
Restart=always
RestartSec=3

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the service
systemctl daemon-reload
systemctl enable short-url.service
systemctl start short-url.service

# Log completion
echo "Short URL app with real UI setup completed at $(date)" > /var/log/short-url-setup.log