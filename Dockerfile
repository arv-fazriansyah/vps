# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update package lists and install necessary packages
RUN apt-get update && \
    apt-get install -y \
    shellinabox \
    tzdata \
    systemd \
    neofetch \
    nano \
    git \
    wget \
    curl \
    sudo \
    openssh-server \
    net-tools && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    # Install Cloudflared
    curl -L --output cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb && \
    dpkg -i cloudflared.deb && \
    rm cloudflared.deb && \
    # Set root password
    echo 'root:root' | chpasswd && \
    # Configure bashrc
    echo 'rm -f $HOME/.bash_history' >> ~/.bashrc && \
    touch ~/.hushlogin && \
    echo -e "service cloudflared start &> /dev/null\nservice ssh start &> /dev/null\nclear\nneofetch" >> ~/.bashrc && \
    echo 'export PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "' >> ~/.bashrc && \
    # Permit root login and disable strict host key checking
    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
    # Set timezone to Asia/Jakarta
    ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata 

# Expose port 4200
EXPOSE 4200

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]
