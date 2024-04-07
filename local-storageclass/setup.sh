kubectl create namespace local-provisioner

kubectl -n local-provisioner apply -f local-provisioner-storageclass.yaml
helm upgrade --install -f values.yaml -n local-provisioner localprovi ./helm/provisioner/
