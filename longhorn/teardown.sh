kubectl create -f https://raw.githubusercontent.com/longhorn/longhorn/v1.4.0/uninstall/uninstall.yaml
kubectl get job/longhorn-uninstall -n longhorn-system -w
kubectl delete -f https://raw.githubusercontent.com/longhorn/longhorn/v1.4.0/deploy/longhorn.yaml
kubectl delete -f https://raw.githubusercontent.com/longhorn/longhorn/v1.4.0/uninstall/uninstall.yaml

