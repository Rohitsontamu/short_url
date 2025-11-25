# Short URL Application - Flask-based URL Shortener

from flask import Flask
from handlers.routes import app
from middlewares.logger import setup_logger
import os

# Initialize logger
logger = setup_logger()

def create_app():
    """Create and configure the Flask application"""
    
    # Ensure database directory exists
    db_dir = os.path.dirname(os.path.abspath(__file__))
    if not os.path.exists(db_dir):
        os.makedirs(db_dir)
    
    # Log application startup
    logger.info("Starting Short URL Application")
    logger.info(f"Database directory: {db_dir}")
    
    return app

# Create the application at module level for Gunicorn
application = create_app()

if __name__ == '__main__':
    # Use the application we already created
    
    # Get configuration from environment variables
    debug_mode = os.getenv('DEBUG', 'True').lower() == 'true'
    host = os.getenv('HOST', '0.0.0.0')
    port = int(os.getenv('PORT', 5000))
    
    logger.info(f"Starting server on {host}:{port} (debug={debug_mode})")
    
    try:
        # Run the application
        application.run(
            debug=debug_mode,
            host=host,
            port=port,
            threaded=True
        )
    except KeyboardInterrupt:
        logger.info("Application stopped by user")
    except Exception as e:
        logger.error(f"Application error: {str(e)}")
        raise