import requests
from flask import Flask, jsonify

app = Flask(__name__)

SERVICE_B_URL = "http://envoy_b:15000"  # Envoy proxy for Service B

@app.route('/')
def home():
    return "Hello from Service A!"

@app.route('/serviceA', methods=['GET'])
def call_serviceB():
    try:
        # Forward the request to Service B
        response = requests.get(f"{SERVICE_B_URL}/serviceB", timeout=5)
        return jsonify(message="Request to Service B succeeded", serviceB_response=response.text), response.status_code
    except requests.exceptions.RequestException as e:
        return jsonify(message="Request to Service B failed", error=str(e)), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)  # Service A listens on port
