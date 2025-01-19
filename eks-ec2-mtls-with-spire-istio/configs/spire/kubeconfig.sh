# The script returns a kubeconfig for the ServiceAccount given
# you need to have kubectl on PATH with the context set to the cluster you want to create the config for

# Cosmetics for the created config
clusterName='eks-ec2-mtls-with-spire-istio'
# your server address goes here get it via `kubectl cluster-info`
server='https://728C94E42EDA6CCCE90096DC8FB1C135.gr7.us-east-1.eks.amazonaws.com'
# the Namespace and ServiceAccount name that is used for the config
namespace='spire-server'
serviceAccount='spire-server'

# The following automation does not work from Kubernetes 1.24 and up.
# You might need to
# define a Secret, reference the ServiceAccount there and set the secretName by hand!
# See https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#manually-create-a-long-lived-api-token-for-a-serviceaccount for details
secretName='spire-server-sa-token'

######################
# actual script starts
set -o errexit


ca=$(kubectl --namespace="$namespace" get secret/"$secretName" -o=jsonpath='{.data.ca\.crt}')
token=$(kubectl --namespace="$namespace" get secret/"$secretName" -o=jsonpath='{.data.token}' | base64 --decode)

echo "
---
apiVersion: v1
kind: Config
clusters:
  - name: ${clusterName}
    cluster:
      certificate-authority-data: ${ca}
      server: ${server}
contexts:
  - name: ${serviceAccount}@${clusterName}
    context:
      cluster: ${clusterName}
      namespace: ${namespace}
      user: ${serviceAccount}
users:
  - name: ${serviceAccount}
    user:
      token: ${token}
current-context: ${serviceAccount}@${clusterName}
"