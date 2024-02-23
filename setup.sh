# Make temporary directory for Docker and minikube installation
tmpDownloadDir="tmpMinikubeInstallDir"
mkdir $tmpDownloadDir

# Install Docker
apt update
apt install -y ca-certificates curl gnupg lsb-release

mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install docker-ce docker-ce-cli containerd.io

# Be able to run Docker without sudo
groupadd docker
gpasswd -a $USER docker
systemctl restart docker

rm -rf $tmpDownloadDir