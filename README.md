# Short URL - URL Shortener

A simple Flask web app that makes long URLs short and trackable. Built as a learning project to practice web development, databases, and containerization.

## What it does

This app takes a long URL (like `https://www.example.com/very/long/url/with/lots/of/parameters`) and creates a short version (like `http://localhost:5000/abc123`). When someone clicks the short link, it redirects them to the original URL and tracks the click.

## Cool features

- Turn long URLs into short ones
- Track how many times links are clicked
- Set links to expire after a certain time
- Nice web interface that works on phones
- REST API for developers
- Prevent spam with rate limiting
- Works with Docker and Kubernetes

## What I learned building this

- **Flask web development**: Building web apps with Python
- **Database design**: Creating tables and relationships with SQLite
- **Frontend skills**: HTML, CSS, and JavaScript
- **Containerization**: Docker and Docker Compose
- **Kubernetes**: Container orchestration and scaling
- **API design**: Creating REST endpoints
- **Testing**: Writing tests with pytest

## What's inside

**Backend:**
- Python 3.11 and Flask for the web server
- SQLite database to store URLs and clicks
- Redis for caching (optional)

**Frontend:**
- HTML, CSS, and JavaScript
- Responsive design that works on mobile
- Copy-to-clipboard functionality

**DevOps stuff:**
- Docker for containerization
- Kubernetes for orchestration
- pytest for testing
- Logging and monitoring

## How to run it

### The easy way (local development)

1. **Get the code**:
   ```bash
   git clone <your-repo-url>
   cd short_url
   ```

2. **Set up Python environment**:
   ```bash
   python -m venv venv
   
   # Windows
   .\venv\Scripts\activate
   
   # Mac/Linux
   source venv/bin/activate
   ```

3. **Install stuff**:
   ```bash
   pip install -r requirements.txt
   ```

4. **Run it**:
   ```bash
   python main.py
   ```

5. **Open your browser**: Go to http://localhost:5000

### With Docker (if you want to be fancy)

```bash
docker-compose up --build
```

### With Kubernetes (if you really want to show off)

```bash
# Windows
.\setup-minikube.ps1

# Mac/Linux
./setup-minikube.sh
```



## How to use the API

You can also use this programmatically instead of the web interface:

### Make a short URL
```bash
curl -X POST http://localhost:5000/shorten \
  -H "Content-Type: application/json" \
  -d '{"url": "https://www.google.com", "expires_hours": 24}'
```

### Get stats about a URL
```bash
curl http://localhost:5000/stats/abc123
```

### See all URLs
```bash
curl http://localhost:5000/api/urls
```

## Project structure

```
short_url/
├── db/                    # Database stuff
│   ├── models.py         # Database tables and operations
│   └── queries.py        # Database queries
├── handlers/
│   └── routes.py         # All the web routes (URLs the app responds to)
├── middlewares/
│   ├── logger.py         # Logging
│   └── rate_limiter.py   # Prevents spam
├── web/                  # HTML templates
│   ├── index.html        # Home page
│   ├── shorturl.html     # Create short URL page
│   └── (error pages)
├── main.py               # Starts the app
├── requirements.txt      # Python packages needed
├── Dockerfile           # For containerization
├── docker-compose.yml   # Run with Docker
└── k8s-manifest.yaml    # Kubernetes setup
```



## If something breaks

### App won't start
```bash
# Check if Python is working
python --version

# Make sure packages are installed
pip list

# Look at the error logs
python main.py
```

### Docker issues
```bash
# See what containers are running
docker ps

# Check the logs
docker logs short-url-app
```

### Kubernetes issues
```bash
# See if pods are running
kubectl get pods -n short-url

# Check what went wrong
kubectl describe pod <pod-name> -n short-url
```

## Cool things to try

Once you have it running, you can:

1. **Create some short URLs** through the web interface
2. **Test the API** with curl commands
3. **Check the database** to see how data is stored:
   ```bash
   sqlite3 urls.db
   .tables
   SELECT * FROM urls;
   ```
4. **Look at the logs** to see what's happening:
   ```bash
   tail -f logs/short_url_*.log
   ```
5. **Try the Docker version** to learn containerization
6. **Deploy to Kubernetes** if you want to learn orchestration

## What I'd add next

If I had more time, I'd add:
- User accounts and login
- Custom short codes (like bit.ly/mycustomlink)
- QR code generation
- Better analytics with graphs
- API rate limiting per user
- Link preview when sharing

## Contributing

Found a bug or want to add a feature? Cool!

1. Fork this repo
2. Make your changes
3. Test that it still works
4. Send a pull request

## License

MIT License - basically you can do whatever you want with this code.

## Questions?

If something doesn't work or you're confused about something, feel free to open an issue. I'm still learning too, so we can figure it out together!