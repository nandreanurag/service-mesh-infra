# Start envoy as daemon process
envoy -c envoy-demo.yaml 
# Start envoy by overiding configuration 
envoy -c envoy-demo.yaml --config-yaml "$(cat envoy-override.yaml)" 
# Validate 
envoy --mode validate -c my-envoy-config.yaml

envoy -c envoy-demo.yaml --log-path logs/custom.log

# The following cmd inhibits all logging except for the upstream and connection components, which are set to debug and trace respectively.
envoy -c envoy-demo.yaml -l off --component-log-level upstream:debug,connection:trace

# Dynamically set log level via Envoy Admin server 
curl -XPOST "localhost:9901/logging?level=debug

# exec container 
docker exec -it containerId /bin/bash