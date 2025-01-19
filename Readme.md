# Service Mesh Infra: Exploring Service Mesh Use Cases

Welcome to the **Service Mesh Infra** repository! This repository showcases practical examples and use cases of service mesh technologies using **Envoy**, **SPIRE**, **AWS**, **Kubernetes**, and **Istio**. Each folder demonstrates a specific feature or benefit of service meshes, helping you understand and implement key patterns such as traffic management, mTLS, security, routing, circuit breaking, and more.

## Repository Structure

This repository is organized into folders, with each folder dedicated to a specific use case. Each folder contains:
- **Codebase**: Implementations using Docker, Envoy, SPIRE, and other relevant technologies.
- **Configuration Files**: Ready-to-use configuration files for quick setup.
- **README**: A detailed explanation of the use case, deployment steps, and features.

### Current Contents

1. **[traffic-management-envoy](./traffic-management-envoy)**
   - Demonstrates traffic management and routing using Envoy as a proxy for three Flask-based web applications.
   - Features:
     - Load balancing and request redirection.
     - Configurable routing for dynamic traffic control.
   - Technologies: Flask, Docker, Envoy.

2. **[mtls-with-spire](./mtls-with-spire)**
   - Implements mutual TLS (mTLS) using SPIRE for certificate management and secure service-to-service communication.
   - Features:
     - Node and workload attestation using SPIRE.
     - Dynamic certificate management via Envoy's SDS.
     - Docker plugin for workload attestation.
   - Technologies: SPIRE, Envoy, Flask, Docker, AWS EC2.

### Upcoming Use Cases

The following use cases will be added soon:

- **Circuit Breaking and Retry Mechanisms with Envoy**
  - Showcase resilience patterns to handle service failures gracefully.
- **Rate Limiting and Authorization**
  - Implement rate limiting policies and fine-grained access control using Istio and Envoy.
- **Observability and Tracing**
  - Explore logging, metrics, and distributed tracing with Prometheus, Grafana, and OpenTelemetry.
- **Service-to-Service Communication on Kubernetes**
  - Demonstrate Istio-based mTLS and traffic management in Kubernetes.
- **Advanced Traffic Splitting**
  - Traffic shaping with canary deployments with heterogeneous environment and A/B testing.


## Getting Started

### Prerequisites
- Docker and Docker Compose installed locally.
- Basic understanding of containerized applications.
- (Optional) AWS account for SPIRE server/agent deployment.

### General Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/nandreanurag/service-mesh-infra.git
   cd service-mesh-infra
