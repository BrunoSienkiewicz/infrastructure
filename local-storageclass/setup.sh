kubectl create namespace local-provisioner

kubectl -n local-provisioner apply -f local_provisioner_storageclass.yaml
helm install -f values.yaml -n local-provisioner localprovi ./helm/provisioner/
