kubectl create namespace local-provisioner

helm repo add sig-storage-local-static-provisioner https://kubernetes-sigs.github.io/sig-storage-local-static-provisioner
helm template --debug sig-storage-local-static-provisioner/local-static-provisioner --version 2.6.0 --namespace local-provisioner > local-volume-provisioner.generated.yaml
