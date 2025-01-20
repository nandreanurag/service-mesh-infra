from diagrams import Diagram, Cluster
from diagrams.aws.compute import EC2
from diagrams.aws.network import VPC
from diagrams.aws.compute import EKS
from diagrams.k8s.infra import Node
from diagrams.k8s.network import Ingress
from diagrams.k8s.compute import Pod
from diagrams.onprem.network import Istio
from diagrams.k8s.network import Ing, SVC, NetworkPolicy
from diagrams.generic.device import Mobile
from diagrams.custom import Custom
# Specify output filename and format
graph_attr = {
    "fontsize": "45"
}

with Diagram( "EKS MTLS with SPIRE and Istio",show=False,filename="eks_mtls_architecture",outformat="png",graph_attr=graph_attr):
    # Create VPC
    user = Mobile("User")
    with Cluster("VPC"):
        # EC2 SPIRE Server
        spire_server = EC2("SPIRE Server")
        
        # EKS Cluster
        with Cluster("EKS Cluster (eks-ec2-mtls-with-spire-istio)"):
            # Create EKS control plane
            eks = Istio("Istiod")
            
            with Cluster("EKS Nodes"):
                with Cluster("Node 1"):
                    with Cluster("istio-system"):
                        istio_ingress = Ing("Istio Ingress")
                        istio_gateway = Istio("Istio Gateway")
                        virtual_service = Istio("Virtual Service")
                        # envoy_istio = Custom("Envoy", "resources/envoy.png")
                        
                    # Create SPIRE agent
                    spire_agent = Pod("SPIRE Agent")
                    
                    # Create Bookinfo components in default namespace
                    with Cluster("Default Namespace (Bookinfo)"):
                        productpage = Pod("productpage")
                        details = Pod("details")
                        reviews = Pod("reviews")
                        ratings = Pod("ratings")
                        istio_proxy_productpage = Custom("istio-proxy(Deployed as side car in each pod)", "resources/envoy.png")
                        # Connect Bookinfo components
                        productpage - istio_proxy_productpage - spire_agent
                        istio_proxy_productpage >> details
                        istio_proxy_productpage >> reviews
                        reviews >> ratings

            # Connect components
            istio_ingress >> productpage
            spire_agent >> spire_server
            eks >> spire_agent
            user >> istio_ingress >> istio_gateway >> virtual_service
            
            # Show MTLS enforcement
            # for worker in workers:
            #     worker - spire_agent