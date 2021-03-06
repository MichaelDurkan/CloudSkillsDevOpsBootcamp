# Create an RBAC
az ad sp create-for-rbac -n "AzureDevOps" --role Contributor --scopes /subscriptions/<Subscription ID>

# Create an RBAC for SDK/programatic access
az ad sp create-for-rbac -n "AzureDevOps" --role Contributor --scopes /subscriptions/<Subscription ID> --sdk-auth
