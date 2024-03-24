# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y shellinabox && \
    apt-get install -y systemd && \
    apt-get install -y neofetch nano git wget curl sudo openssh-server net-tools && \
    curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb && \
    rm cloudflared.deb && \
    echo 'root:root' | chpasswd && \
    echo 'rm -f $HOME/.bash_history' >> ~/.bashrc && \
    touch ~/.hushlogin && \
    echo -e "service cloudflared start &> /dev/null\nservice ssh start &> /dev/null\nclear\nneofetch" >> ~/.bashrc && \
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    echo "StrictHostKeyChecking no" >> /etc/ssh/ssh_config && \
    echo 'export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "' >> ~/.bashrc && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Expose port 4200
EXPOSE 4200

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]

# docker build -t ubuntu .
# docker run -d -p 8080:80 ubuntu
# docker tag ubuntu:latest fazriansyah/ubuntu:latest
# docker push fazriansyah/ubuntu:latest
# docker rmi -f $(docker images -q)
# docker stop $(docker ps -q)
# docker rm $(docker ps -aq)
# docker rm IDIMAGES
# docker build -t warp-clash-api .
# docker tag warp-clash-api:latest fazriansyah/warp-clash-api:latest
# docker push fazriansyah/warp-clash-api:latest
