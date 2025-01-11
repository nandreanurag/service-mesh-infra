# Traffic and Route Management with Envoy Proxy

This folder demonstrates **traffic management** and **route handling** using Envoy as a sidecar proxy for containerized web applications.

## Overview

In this example, three Flask-based web applications are deployed as Docker containers. Each Flask app has an Envoy container running alongside it as a proxy. Envoy manages all incoming and outgoing requests, showcasing the traffic management and routing capabilities of Envoy.

## Features Demonstrated

1. **Traffic Management**:
   - Envoy handles requests directed to the Flask applications.
   - Load balancing and request redirection are managed seamlessly.

2. **Routing**:
   - Configurable routes direct incoming requests to the appropriate Flask application.
   - Envoy performs routing based on URL paths or other request attributes.

3. **Service Mesh Basics**:
   - Sidecar proxies for inter-service communication.
   - Centralized configuration for consistent traffic rules.

## Architecture

The setup includes:
- **3 Flask Web Applications**:
  - Simple Python-based services running different endpoints.
- **Envoy Proxy (Sidecar)**:
  - Deployed alongside each Flask app.
  - Handles all HTTP traffic for the application.

### Diagram

Client | v Envoy Proxy (Entry Point) | v +-----------------------+ | Services | | | | Flask App 1 (Envoy) | | Flask App 2 (Envoy) | | Flask App 3 (Envoy) | +-----------------------+

## Envoy Configuration
- **envoy-config.yaml define**:
  - Routes for each Flask service

## Deployment

### Prerequisites
- Docker installed locally.
- Basic understanding of Flask and Envoy.

### Steps

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/service-mesh-infra.git
   cd service-mesh-infra/traffic-management

2. **Build**:
   docker-compose build

3. **Deploy**:
   docker-compose up 

3. **Test**:
   curl -k -v http://localhost:10000/serviceA
   Response:
   {"message":"Request to Service B succeeded","serviceB_response":"{\"message\":\"Request to Service C succeeded\",\"serviceC_response\":\"Hello from Service C!\"}\n"}

4. **Clean Up**:
   docker-compose down --rmi all


