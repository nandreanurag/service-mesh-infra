wget https://github.com/spiffe/spire/releases/download/v1.11.1/spire-1.11.1-linux-amd64-musl.tar.gz
tar zvxf spire-1.11.1-linux-amd64-musl.tar.gz
sudo cp -r spire-1.11.1/. /opt/spire/
sudo useradd -r -s /bin/false spire  # create dedicated spire user
sudo -u spire mkdir -p /opt/spire/data/agent
sudo -u spire mkdir -p /opt/spire/conf

# Install docker and docker-compose
sudo yum install -y docker
sudo systemctl start docker
sudo systemctl enable docker
sudo curl -L "https://github.com/docker/compose/releases/download/v2.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# grant access to docker socket Add spire User to the docker Group
sudo usermod -aG docker spire 


sudo systemctl daemon-reload
sudo systemctl enable spire-agent-service.service
sudo systemctl start spire-agent-service.service
sudo systemctl status spire-agent-service.service