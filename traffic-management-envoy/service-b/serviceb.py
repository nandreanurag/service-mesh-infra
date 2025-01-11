import requests
from flask import Flask, jsonify

app = Flask(__name__)

SERVICE_C_URL = "http://envoy_c:15000" # Envoy proxy for Service C

@app.route('/')
def home():
    return "Hello from Service B!"

@app.route('/serviceB', methods=['GET'])
def call_serviceC():
    try:
        # Forward the request to Service C
        response = requests.get(f"{SERVICE_C_URL}/", timeout=5)
        return jsonify(message="Request to Service C succeeded", serviceC_response=response.text), response.status_code
    except requests.exceptions.RequestException as e:
        return jsonify(message="Request to Service C failed", error=str(e)), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)  # Service B listens on port 10001
