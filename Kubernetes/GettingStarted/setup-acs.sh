#! /bin/sh
# Replace the following variables with an UNIQUE name
RG=<<myK8s Cluster Resource Group>>
CLUSTERNAME=<<myK8s Cluster>>

# Creat Resource Group
az group create --name myK8sCluster --location westeurope

# Create Cluster without Owner role on Subscription on Bash
chmod +x obtainAzureSP.sh
./obtainAzureSP.sh
#az acs create --orchestrator-type kubernetes --resource-group "$RG" --name "$CLUSTERNAME" --service-principal "$AZURE_CLIENT_ID" --client-secret "$AZURE_CLIENT_SECRET" --agent-vm-size Standard_DS3_v2 --agent-count 2 --generate-ssh-keys
az acs create --orchestrator-type kubernetes --resource-group "$RG" --name "$CLUSTERNAME" --service-principal "$AZURE_CLIENT_ID" --client-secret "$AZURE_CLIENT_SECRET" --agent-vm-size Standard_DS3_v2 --agent-count 2 

# Must for first time only ; Install Kubectl CLI. If you are using Windows than kubectl is in program files (x86). Make sure it is in your PATH variable
az acs kubernetes install-cli

# Connect kubectl to cluster
az acs kubernetes get-credentials --resource-group="$RG" --name="$CLUSTERNAME"

# Proxy to the dashboard
kubectl proxy
