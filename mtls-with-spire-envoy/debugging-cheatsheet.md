# cmd to check health
/opt/spire/bin/spire-server healthcheck   

# cmd to view bundle
/opt/spire/bin/spire-server bundle show  

# create workload entry
/opt/spire/bin/spire-server entry create \
    -parentID spiffe://example.org/spire/agent/aws_iid/905418187025/us-east-1/i-088f0b951bfa7bd31 \
    -spiffeID spiffe://example.org/aws_iid/905418187025/us-east-1/i-088f0b951bfa7bd31/docker/envoy_a \
    -selector docker:label:com.docker.compose.service:envoy_a

# list agents on server
/opt/spire/bin/spire-server agent list 

# evict agent
/opt/spire/bin/spire-server agent evict -spiffeID  spiffe://ex

# show workload entries
/opt/spire/bin/spire-server entry show

# openssl to inspect the certificate presented by Envoy B & validate certificate chain
openssl s_client -connect envoy_b:15000 -showcerts



# verify if they have crct svid and trust bundle 
openssl x509 -in svid-cert.pem -text -noout

# debug certificate:
openssl x509 -in certificate.crt -text -noout



*****  mTLS Testing *****

# create an test workload for mocking requests
sudo /opt/spire/bin/spire-server entry create \
  -spiffeID spiffe://example.org/test/dummy-workload \
  -parentID spiffe://example.org/spire/agent/aws_iid/905418187025/us-east-1/i-088f0b951bfa7bd31 \
  -selector unix:uid:1000 \
  -x509SVIDTTL 3600

# Generate credentials(i.e svid, private key, trust bundle) for above mock workload
sudo /opt/spire/bin/spire-server x509 mint \
  -spiffeID spiffe://example.org/test/dummy-workload \
  -socketPath /tmp/spire-server/private/api.sock \
  -write /home/ec2-user/dummy

# you need to present svid,trust bundle, key of mock workload to access service A
curl -v \
  --cacert bundle.pem \
  --cert svid.pem \
  --key  key.pem \
    https://public-ip-of-agent:10000/serviceA