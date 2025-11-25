# Database queries for the short URL application

from db.models import URLModel
from typing import List, Optional, Dict


class URLQueries:
    def __init__(self, db_path: str = "urls.db"):
        self.model = URLModel(db_path)
    
    def create_short_url(self, original_url: str, expires_hours: Optional[int] = None) -> str:
        """Create a new short URL"""
        return self.model.create_short_url(original_url, expires_hours)
    
    def get_original_url(self, short_code: str) -> Optional[str]:
        """Get original URL by short code"""
        url_data = self.model.get_url_by_short_code(short_code)
        
        if not url_data:
            return None
        
        if self.model.is_url_expired(url_data):
            return None
        
        return url_data['original_url']
    
    def track_click(self, short_code: str, ip_address: str, user_agent: str) -> bool:
        """Track a click on a short URL"""
        url_data = self.model.get_url_by_short_code(short_code)
        
        if not url_data or self.model.is_url_expired(url_data):
            return False
        
        self.model.increment_click_count(url_data['id'], ip_address, user_agent)
        return True
    
    def get_url_stats(self, short_code: str) -> Optional[Dict]:
        """Get statistics for a short URL"""
        url_data = self.model.get_url_by_short_code(short_code)
        
        if not url_data:
            return None
        
        return {
            'short_code': url_data['short_code'],
            'original_url': url_data['original_url'],
            'created_at': url_data['created_at'],
            'expires_at': url_data['expires_at'],
            'click_count': url_data['click_count'],
            'is_expired': self.model.is_url_expired(url_data)
        }
    
    def get_all_urls(self, limit: int = 100) -> List[Dict]:
        """Get all URLs with their statistics"""
        import sqlite3
        
        conn = sqlite3.connect(self.model.db_path)
        cursor = conn.cursor()
        
        cursor.execute('''
            SELECT id, original_url, short_code, created_at, expires_at, click_count, is_active
            FROM urls WHERE is_active = 1
            ORDER BY created_at DESC
            LIMIT ?
        ''', (limit,))
        
        rows = cursor.fetchall()
        conn.close()
        
        results = []
        for row in rows:
            url_data = {
                'id': row[0],
                'original_url': row[1],
                'short_code': row[2],
                'created_at': row[3],
                'expires_at': row[4],
                'click_count': row[5],
                'is_active': row[6]
            }
            
            results.append({
                'short_code': url_data['short_code'],
                'original_url': url_data['original_url'],
                'created_at': url_data['created_at'],
                'expires_at': url_data['expires_at'],
                'click_count': url_data['click_count'],
                'is_expired': self.model.is_url_expired(url_data)
            })
        
        return results