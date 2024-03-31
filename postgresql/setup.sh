source .env

kubectl create ns postgresql

kubectl create -n postgresql secret generic postgresql \
    --from-literal=POSTGRES_USER=${SECRET_POSTGRES_USER} \
    --from-literal=POSTGRES_PASSWORD=${SECRET_POSTGRES_PASSWORD} \
    --from-literal=POSTGRES_DB=${SECRET_POSTGRES_DB} \
    --from-literal=REPLICATION_USER=${SECRET_REPLICATION_USER} \
    --from-literal=REPLICATION_PASS=${SECRET_REPLICATION_PASS}

kubectl -n postgresql apply -f storage.yaml
kubectl -n postgresql apply -f configmap.yaml
kubectl -n postgresql apply -f statefulset.yaml
kubectl -n postgresql apply -f statefulset-replica.yaml
kubectl -n postgresql apply -f service.yaml

unset SECRET_POSTGRES_USER SECRET_POSTGRES_PASSWORD SECRET_POSTGRES_DB SECRET_REPLICATION_USER SECRET_REPLICATION_PASS

