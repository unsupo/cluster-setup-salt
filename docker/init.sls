
docker_boostraper_run:
  cmd.run:
    - name: curl -sSL get.docker.com | CHANNEL=stable sh && sudo usermod pi -aG docker && newgrp docker > /root/docker-output.log
    - creates: /root/docker-output.log
    # - name: /root/get-docker.sh
    # - skip_verify: True

# issues fix:
# apt-get remove docker docker-engine docker.io
# sudo apt-get install \
#    apt-transport-https \
#    ca-certificates \
#    curl \
#    software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# verify fingerprint  sudo apt-key fingerprint 0EBFCD88
# sudo add-apt-repository \
#   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#   $(lsb_release -cs) \
#   stable"
# sudo apt-get update
# sudo apt-get install docker-ce # or sudo apt-get install docker-ce=<VERSION>

# snap install docker for 18.06.1-ce

# sudo apt install apt-transport-https ca-certificates curl software-properties-common
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
# sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic test"
# sudo apt update
# sudo apt install docker-ce

# docker_boostraper_run:
#   cmd.run:
#     - name: sh /root/get-docker.sh


    # sudo usermod pi -aG docker
    # newgrp docker
