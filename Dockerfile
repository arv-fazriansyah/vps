# Use a base image that supports systemd, for example, Ubuntu
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y shellinabox && \
    apt-get install -y systemd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN echo 'root:root' | chpasswd

# Expose the web-based terminal port
# EXPOSE 4200
EXPOSE 3000

# Start shellinabox
CMD ["/usr/bin/shellinaboxd", "-t", "-s", "/:LOGIN"]

# docker build -t ubuntu .
# docker run -d -p 8080:80 ubuntu
# docker tag ubuntu:latest fazriansyah/ubuntu:latest
# docker push fazriansyah/ubuntu:latest
