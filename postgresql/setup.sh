source .env

kubectl create ns postgresql

export POSTGRES_USER=$SECRET_POSTGRES_USER
export POSTGRES_PASS=$SECRET_POSTGRES_PASS
export POSTGRES_DB="postgres"
export REPLICATION_USER=$SECRET_REPLICATION_USER
export REPLICATION_PASS=$SECRET_REPLICATION_PASS

kubectl create -n postgresql secret generic postgresql \
    --from-literal=POSTGRES_USER=${POSTGRES_USER} \
    --from-literal=POSTGRES_PASS=${POSTGRES_PASS} \
    --from-literal=POSTGRES_DB=${POSTGRES_DB} \
    --from-literal=REPLICATION_USER=${REPLICATION_USER} \
    --from-literal=REPLICATION_PASS=${REPLICATION_PASS}

kubectl -n postgresql apply -f storage.yaml
kubectl -n postgresql apply -f statefulset.yaml

unset POSTGRES_USER POSTGRES_PASS POSTGRES_DB REPLICATION_USER REPLICATION_PASS


