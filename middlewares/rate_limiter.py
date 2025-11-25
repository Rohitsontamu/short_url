# Rate limiter middleware for the short URL application

import time
from typing import Dict, Tuple
from threading import Lock


class RateLimiter:
    """Simple in-memory rate limiter"""
    
    def __init__(self, max_requests: int = 10, window_seconds: int = 60):
        """
        Initialize rate limiter
        
        Args:
            max_requests: Maximum number of requests allowed per window
            window_seconds: Time window in seconds
        """
        self.max_requests = max_requests
        self.window_seconds = window_seconds
        self.requests: Dict[str, list] = {}
        self.lock = Lock()
    
    def is_allowed(self, client_id: str) -> bool:
        """
        Check if client is allowed to make a request
        
        Args:
            client_id: Identifier for the client (usually IP address)
            
        Returns:
            True if request is allowed, False otherwise
        """
        current_time = time.time()
        
        with self.lock:
            # Initialize client's request history if not exists
            if client_id not in self.requests:
                self.requests[client_id] = []
            
            # Remove old requests outside the window
            self.requests[client_id] = [
                req_time for req_time in self.requests[client_id]
                if current_time - req_time < self.window_seconds
            ]
            
            # Check if under the limit
            if len(self.requests[client_id]) < self.max_requests:
                self.requests[client_id].append(current_time)
                return True
            
            return False
    
    def get_reset_time(self, client_id: str) -> float:
        """
        Get the time when the rate limit resets for a client
        
        Args:
            client_id: Identifier for the client
            
        Returns:
            Unix timestamp when the limit resets
        """
        current_time = time.time()
        
        with self.lock:
            if client_id not in self.requests or not self.requests[client_id]:
                return current_time
            
            # Find the oldest request in the current window
            oldest_request = min(self.requests[client_id])
            return oldest_request + self.window_seconds
    
    def get_remaining_requests(self, client_id: str) -> int:
        """
        Get the number of remaining requests for a client
        
        Args:
            client_id: Identifier for the client
            
        Returns:
            Number of remaining requests
        """
        current_time = time.time()
        
        with self.lock:
            if client_id not in self.requests:
                return self.max_requests
            
            # Remove old requests outside the window
            self.requests[client_id] = [
                req_time for req_time in self.requests[client_id]
                if current_time - req_time < self.window_seconds
            ]
            
            return max(0, self.max_requests - len(self.requests[client_id]))
    
    def clear_client(self, client_id: str):
        """Clear rate limit data for a specific client"""
        with self.lock:
            if client_id in self.requests:
                del self.requests[client_id]
    
    def clear_all(self):
        """Clear all rate limit data"""
        with self.lock:
            self.requests.clear()