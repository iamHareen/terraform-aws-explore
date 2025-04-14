# Simple Flask web application
from flask import Flask
import os

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello, I'm Hareen Helanjith"

if __name__ == '__main__':
    # Get port from environment variable or default to 5000
    port = int(os.environ.get('PORT', 5001))
    # Run the application on 0.0.0.0 to be accessible outside the container
    app.run(host='0.0.0.0', port=port)