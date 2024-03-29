kubectl create ns traefik

helm repo add traefik https://traefik.github.io/charts
helm repo update
helm upgrade --install traefik traefik/traefik --namespace=traefik --values=values.yaml --debug

