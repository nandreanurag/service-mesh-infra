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

2. **[eks-ec2-mtls-with-spire](./eks-ec2-mtls-with-spire)**
   - Demonstrates mutual TLS (mTLS) and traffic management between heterogenous workloads on **EKS** and **EC2** using Istio and SPIRE.
   - **Features**:
     - Secure communication between EKS workloads and EC2 instances with Envoy proxies.
     - SPIRE-SERVER runs on a VM and acts as a Certificate Authority (CA) to issue and manage certificates for both environments.
     - EKS Ingress Gateway to route traffic from EC2 to Kubernetes services.
     - Istio as control plane 
     - Dynamic certificate provisioning via SPIRE's SDS.
   - **Technologies**: SPIRE, Envoy, Kubernetes (EKS), Flask, Docker, AWS EC2.


### Upcoming Use Cases

The following use cases will be added soon:

- **Circuit Breaking and Retry Mechanisms with Envoy**
  - Showcase resilience patterns to handle service failures gracefully.
- **Rate Limiting and Authorization**
  - Implement rate limiting policies and fine-grained access control using Istio and Envoy.
- **Observability and Tracing**
  - Explore logging, metrics, and distributed tracing with Prometheus, Grafana, and OpenTelemetry.
- **Advanced Traffic Splitting**
  - Traffic shaping with canary deployments with heterogeneous environment and A/B testing.
- **Managing Service Mesh on VMs with Dynamic Envoy Resources**
  - Demonstrate service mesh management for workloads running on virtual machines (VMs).
  - Use **xDS API** to dynamically configure Envoy proxies with a custom control plane server.
  - Integrate a service registry like **Eureka** or **Consul** to discover and manage services.
  - Showcase dynamic resource updates such as clusters, endpoints, routes, and listeners in Envoy.
- **Adding a Virtual Machine (VM) to a Service Mesh**
  - Extend the service mesh to include VMs alongside containerized workloads.
  - Integrate the VM into an existing service mesh (e.g., Istio) with **SPIRE** for identity and mTLS.
  - Demonstrate service discovery and routing between the VM and mesh workloads.


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
