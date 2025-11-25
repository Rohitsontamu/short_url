# Database models for the short URL application

from datetime import datetime, timedelta
from typing import Optional
import sqlite3
import hashlib
import random
import string


class URLModel:
    def __init__(self, db_path: str = "urls.db"):
        self.db_path = db_path
        self.init_db()
    
    def init_db(self):
        """Initialize the database with required tables"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS urls (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                original_url TEXT NOT NULL,
                short_code TEXT UNIQUE NOT NULL,
                created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                expires_at TIMESTAMP,
                click_count INTEGER DEFAULT 0,
                is_active BOOLEAN DEFAULT 1
            )
        ''')
        
        cursor.execute('''
            CREATE TABLE IF NOT EXISTS clicks (
                id INTEGER PRIMARY KEY AUTOINCREMENT,
                url_id INTEGER,
                clicked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                ip_address TEXT,
                user_agent TEXT,
                FOREIGN KEY (url_id) REFERENCES urls (id)
            )
        ''')
        
        conn.commit()
        conn.close()
    
    def generate_short_code(self, length: int = 6) -> str:
        """Generate a unique short code"""
        characters = string.ascii_letters + string.digits
        while True:
            short_code = ''.join(random.choice(characters) for _ in range(length))
            if not self.get_url_by_short_code(short_code):
                return short_code
    
    def create_short_url(self, original_url: str, expires_hours: Optional[int] = None) -> str:
        """Create a new short URL entry"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        short_code = self.generate_short_code()
        expires_at = None
        
        if expires_hours:
            expires_at = datetime.now() + timedelta(hours=expires_hours)
        
        cursor.execute('''
            INSERT INTO urls (original_url, short_code, expires_at)
            VALUES (?, ?, ?)
        ''', (original_url, short_code, expires_at))
        
        conn.commit()
        conn.close()
        
        return short_code
    
    def get_url_by_short_code(self, short_code: str) -> Optional[dict]:
        """Get URL data by short code"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            SELECT id, original_url, short_code, created_at, expires_at, click_count, is_active
            FROM urls WHERE short_code = ? AND is_active = 1
        ''', (short_code,))
        
        row = cursor.fetchone()
        conn.close()
        
        if row:
            return {
                'id': row[0],
                'original_url': row[1],
                'short_code': row[2],
                'created_at': row[3],
                'expires_at': row[4],
                'click_count': row[5],
                'is_active': row[6]
            }
        return None
    
    def is_url_expired(self, url_data: dict) -> bool:
        """Check if URL has expired"""
        if not url_data['expires_at']:
            return False
        
        expires_at = datetime.fromisoformat(url_data['expires_at'])
        return datetime.now() > expires_at
    
    def increment_click_count(self, url_id: int, ip_address: str, user_agent: str):
        """Increment click count and log the click"""
        conn = sqlite3.connect(self.db_path)
        cursor = conn.cursor()
        
        # Update click count
        cursor.execute('''
            UPDATE urls SET click_count = click_count + 1 WHERE id = ?
        ''', (url_id,))
        
        # Log the click
        cursor.execute('''
            INSERT INTO clicks (url_id, ip_address, user_agent)
            VALUES (?, ?, ?)
        ''', (url_id, ip_address, user_agent))
        
        conn.commit()
        conn.close()