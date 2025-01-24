# Docker-Local-Docker-Registry
Deploy a local docker Docker Registry ready tu use with Kubernetes, RootCA creation, SSL certificates signed by local RootCA

### Copy certificates 
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