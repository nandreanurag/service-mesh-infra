envoy -c envoy-demo.yaml  -- Start envoy as daemon process
envoy -c envoy-demo.yaml --config-yaml "$(cat envoy-override.yaml)"  -- start envoy by overiding configuration
envoy --mode validate -c my-envoy-config.yaml
envoy -c envoy-demo.yaml --log-path logs/custom.log
The following example inhibits all logging except for the upstream and connection components, which are set to debug and trace respectively.
envoy -c envoy-demo.yaml -l off --component-log-level upstream:debug,connection:trace

cmd to dynamically set log level via admin server - curl -XPOST "localhost:9901/logging?level=debug

cmd to exec container - docker exec -it containerId /bin/bash