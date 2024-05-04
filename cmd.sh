# create dockerhub-token
# change demo to your account
kubectl create secret docker-registry dockerhub-registrykey --docker-username=demo --docker-password=demo --docker-email=demo@gmail.com --namespace=bazooka168

# create env to secret
kubectl create secret generic bazooka168-member-env --namespace=bazooka168 --from-env-file=.env
kubectl create secret generic bazooka168-backoffice-env --namespace=bazooka168 --from-env-file=.env
kubectl create secret generic bazooka168-api-env --namespace=bazooka168 --from-env-file=.env
