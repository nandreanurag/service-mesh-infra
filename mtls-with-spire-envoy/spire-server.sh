wget https://github.com/spiffe/spire/releases/download/v1.11.1/spire-1.11.1-linux-amd64-musl.tar.gz
tar zvxf spire-1.11.1-linux-amd64-musl.tar.gz
sudo cp -r spire-1.11.1/. /opt/spire/
sudo useradd -r -s /bin/false spire  # create dedicated spire user
sudo chown -R spire:spire /opt/spire
sudo -u spire mkdir -p /opt/spire/data/server
sudo -u spire mkdir -p /opt/spire/conf
sudo systemctl daemon-reload
sudo systemctl enable spire-server-service.service
sudo systemctl start spire-server-service.service
sudo systemctl status spire-server-service.service