
import logging
import os
from datetime import datetime

# --- 1. Import the CORRECT Splunk handler ---
try:
    from splunk_hec_handler import SplunkHecHandler
    SPLUNK_AVAILABLE = True
except ImportError:
    SPLUNK_AVAILABLE = False
    print("splunk-hec-handler package not found. Skipping Splunk integration.")


def setup_logger(name: str = 'short_url', log_level: str = 'INFO') -> logging.Logger:
    """Setup and configure logger"""
    
    log_dir = 'logs'
    if not os.path.exists(log_dir):
        os.makedirs(log_dir)
    
    logger = logging.getLogger(name)
    logger.setLevel(getattr(logging, log_level.upper(), logging.INFO))
    
    if logger.handlers:
        return logger
    
    # --- Standard File & Console Handlers ---
    file_formatter = logging.Formatter(
        '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
    )
    console_formatter = logging.Formatter(
        '%(asctime)s - %(levelname)s - %(message)s'
    )
    
    log_file = os.path.join(log_dir, f'{name}_{datetime.now().strftime("%Y%m%d")}.log')
    file_handler = logging.FileHandler(log_file)
    file_handler.setLevel(logging.DEBUG)
    file_handler.setFormatter(file_formatter)
    
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)
    console_handler.setFormatter(console_formatter)
    
    logger.addHandler(file_handler)
    logger.addHandler(console_handler)

    # --- 2. Add Splunk HEC Handler ---
    if SPLUNK_AVAILABLE:
        SPLUNK_HOST = os.getenv('SPLUNK_HOST')
        SPLUNK_HEC_TOKEN = os.getenv('SPLUNK_HEC_TOKEN')
        
        if SPLUNK_HOST and SPLUNK_HEC_TOKEN:
            try:
                splunk_handler = SplunkHecHandler(
                    host=SPLUNK_HOST,
                    token=SPLUNK_HEC_TOKEN,
                    port=int(os.getenv('SPLUNK_HEC_PORT', 8088)),
                    proto=os.getenv('SPLUNK_HEC_PROTO', 'http'),
                    verify=os.getenv('SPLUNK_HEC_VERIFY_SSL', 'False').lower() == 'true',
                    timeout=5.0
                )
                
                splunk_formatter = logging.Formatter('%(levelname)s - %(module)s - %(message)s')
                splunk_handler.setFormatter(splunk_formatter)
                splunk_handler.setLevel(logging.INFO)
                
                logger.addHandler(splunk_handler)
                logger.info("Splunk HEC logger successfully initialized.")
                
            except Exception as e:
                logger.error(f"Failed to initialize Splunk HEC handler: {str(e)}")
        else:
            logger.info("Splunk HEC environment variables not set. Skipping Splunk.")

    return logger


def log_request(logger: logging.Logger):
    """Decorator to log incoming requests"""
    def decorator(func):
        def wrapper(*args, **kwargs):
            from flask import request
            logger.info(f"Request: {request.method} {request.path} from {request.remote_addr}")
            return func(*args, **kwargs)
        wrapper.__name__ = func.__name__
        return wrapper
    return decorator