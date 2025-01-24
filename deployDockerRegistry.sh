# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo mkdir -p /registry/certs
sudo mkdir -p /registry/auth

sudo openssl req -newkey rsa:4096 -sha256 -nodes -keyout /registry/certs/docker-registry.key -out docker-registry.csr -subj "/C=CH/ST=VD/L=SteCroix/O=LoucSA/CN=docker-registry.louc.ch"

# Création de la Root CA
sudo openssl req -x509 -sha256 -days 1825 -newkey rsa:2048 -keyout rootCA.key -subj "/C=CH/ST=VD/L=SteCroix/O=LoucSA/CN=root-ca.LoucSA.local" -out rootCA.crt

sudo cat << 'EOF' > docker-registry.ext
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
subjectAltName = @alt_names
[alt_names]
DNS.1 = docker-registry
DNS.2 = docker-registry.louc.ch
EOF

# Signature du cértificats par la Root CA
sudo openssl x509 -req -CA rootCA.crt -CAkey rootCA.key -in docker-registry.csr -out /registry/certs/docker-registry.crt -days 365 -CAcreateserial -extfile docker-registry.ext

# Set identity file
cd /registry/auth
sudo htpasswd -Bc /registry/auth/registry.passwd reg-user
cd 

sudo systemctl restart docker



