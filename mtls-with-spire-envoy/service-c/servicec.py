from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello from Service C!"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002)  # Service C listens on port 10002
