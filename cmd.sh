# create dockerhub-token
# change demo to your account
kubectl create secret docker-registry dockerhub-registrykey --docker-username=demo --docker-password=demo --docker-email=demo@gmail.com --namespace=demo-web

# create env to secret
kubectl create secret generic demo-web-env --namespace=demo --from-env-file=.env
