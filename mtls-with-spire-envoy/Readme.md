# mTLS with SPIRE and Envoy

This folder demonstrates **mutual TLS (mTLS)** using Envoy and SPIRE for secure service-to-service communication. It builds on the previous example of traffic and route management but introduces **SPIRE** to manage dynamic certificate provisioning and secure identity.

## Overview

In this example, **SPIRE** is integrated with Envoy to provide secure service discovery and certificate management using **SDS (Secret Discovery Service)**. The following steps were performed:

1. **SPIRE Server**:
   - Deployed on an EC2 instance with an IAM role to describe and fetch instance metadata.
   - Manages trust domains and node attestation.

2. **SPIRE Agent**:
   - Deployed on another EC2 instance.
   - Handles node and workload attestation.

3. **mTLS Configuration**:
   - Envoy is configured to use SPIRE for dynamic mTLS certificate provisioning.
   - Ensures secure service-to-service communication between the Flask web apps.

4. **Docker Workload Attestation**:
   - SPIRE Agent uses the Docker plugin to attest workloads deployed in containers.

## Features Demonstrated

1. **mTLS**:
   - Encrypted and authenticated communication between services.

2. **Dynamic Certificate Management**:
   - Certificates are dynamically issued and rotated by SPIRE.

3. **Secure Node and Workload Attestation**:
   - Node attestation using trust bundles.
   - Workload attestation using Docker plugin.

## Architecture

The architecture includes:
- **SPIRE Server**:
  - Deployed on a VM (EC2 instance).
  - Manages trust bundles and verifies nodes during attestation.
- **SPIRE Agent**:
  - Deployed on a separate VM (EC2 instance).
  - Attests nodes and Docker workloads.
- **Dockerized Flask Web Applications**:
  - Deployed on the SPIRE Agent node.
  - Communicate securely via Envoy proxies.

### Diagram

+----------------+         +----------------+
|  SPIRE Server  |         |  SPIRE Agent   |
| (Trust Domain) |         |  (Node Agent)  |
+----------------+         +----------------+
        |                          |
        | Trust Bundle             | Node Attestation
        |                          |
+----------------+        +------------------------+
|   Dockerized   |<-------| Docker Workload        |
|   Flask Apps   |        | Attestation            |
+----------------+        +------------------------+
        ^                          ^
        | mTLS                     | mTLS
+----------------+        +------------------------+
| Envoy Proxy   |        | Envoy Proxy            |
+----------------+        +------------------------+


## Deployment

### Prerequisites
- Two EC2 instances with Docker & Docker Compose installed on agent EC2.
- SPIRE binaries downloaded on both instances.
- IAM role for SPIRE Server EC2 instance with permissions to describe and fetch instances.

### Steps

1. **Set Up SPIRE Server**:
   - Attach IAM role to spire-server
   - Place spire-server-service.service at /etc/systemd/system/spire-server-service.service
   - Place ./spire-server/spire-server.conf at /opt/spire/conf/server/spire-server.conf
   - Install and Start the SPIRE server as a daemon:
     ```bash
     ./spire-server
     ```

2. **Set Up SPIRE Agent**:
   - Place spire-agent-service.service at /etc/systemd/system/spire-agent-service.service
   - Place ./spire-server/spire-agent.conf at /opt/spire/conf/server/spire-agent.conf
   - Copy the trust bundle from the server to the agent:
     ```bash
     scp -i trust_bundle-agent.pem  /server-path/to/trust_bundle.pem ec2-user@agent-public-ip:/path/to/trust_bundle.pem
     ```
   - Install and Start the SPIRE agent as a daemon:
     ```bash
     ./spire-agent 
     ```

3. **Node Attestation**:
   - Ensure the agent is successfully attested by the server via spire-server agent list .

4. **Create Workload Entries**:
   - Create below workload entries on spire server for workload attestation:
     ```bash
     /opt/spire/bin/spire-server entry create \
    -parentID spiffe://example.org/spire/agent/aws_iid/905418187025/us-east-1/i-088f0b951bfa7bd31 \
    -spiffeID spiffe://example.org/aws_iid/905418187025/us-east-1/i-088f0b951bfa7bd31/docker/envoy_a \
    -selector docker:label:com.docker.compose.service:envoy_a

    #similarly create for service b,c
     ```

5. **Deploy Applications**:
   - Use Docker to deploy Flask apps on the agent EC2 instance:
     ```bash
     docker-compose up -d
     ```


## Testing mTLS

1. Verify that the SPIRE server and agent are running:
   ```bash
   refer ./debugging-cheatsheet.md for cmds
