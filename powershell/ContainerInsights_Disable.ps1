# Use the following commands in order to authenticate, disable, and check the local status of Container Insights
az aks get-credentials --admin --name aks-demo --resource-group aksrg
az aks disable-addons -a monitoring -n 'clustername' -g 'clusterRG'

# ONCE INSIGHTS DISABLED, THE PODS AND DEPLOYMENT SHOULD BE DELETED FROM CLUSTER AUTOMATICALLY
# IF CONTAINER INSIGHTS IS NOT ENABLED FROM PORTAL, AND THESE PODS/DEPLOYMENT EXIST, DELETE THEM BEFORE RE-ENABLING INSIGHTS WITH BELOW COMMANDS

kubectl get deployment --namespace=kube-system
kubectl get pods --namespace=kube-system

# Use the following commands to delete the deployment and pods from AKS AFTER Insights disabled from the portal (only if needed)

# kubectl delete deployment 'deploymentname'
# kubectl delete pod 'ama-logs-xxxxx' --namespace=kube-system 


