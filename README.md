# Docker-Local-Docker-Registry
Deploy a local docker Docker Registry ready tu use with Kubernetes, RootCA creation, SSL certificates signed by local RootCA

## Docker-Registry commands
```sh
# login to registry
docker login docker-registry.louc.ch -u reg-user -p reg-user

# build, tag and push 
sudo docker build --no-cache -t prometheus .
sudo docker tag prometheus:latest docker-registry.louc.ch/prometheus:v1
sudo docker push docker-registry.louc.ch/prometheus:v1
```



## Docker-Registry curl commands
```sh
# list repositories
curl -X GET -u reg-user:reg-user https://docker-registry.louc.ch/v2/_catalog

# list tag of an image
curl -X GET -u reg-user:reg-user https://docker-registry.louc.ch/alertmanager/tags/list
```

## Copy certificates and update docker-registry clients CA 
```sh
sudo scp rootCA.crt root@192.168.188.5:/usr/local/share/ca-certificates
sudo scp rootCA.crt root@192.168.188.7:/usr/local/share/ca-certificates
sudo ssh root@192.168.188.5 update-ca-certificates
sudo ssh root@192.168.188.7 update-ca-certificates

# --- à verifier si obligatoire ---#

#sudo mkdir -p /etc/docker/certs.d/registry.docker-regitry.louc.ch/
#sudo cp rootCA.crt /etc/docker/certs.d/registry.docker-regitry.louc.ch/

#sudo mkdir -p /usr/share/ca-certificates/extra/
#sudo cp rootCA.crt /usr/share/ca-certificates/extra/
#sudo update-ca-certificates
```