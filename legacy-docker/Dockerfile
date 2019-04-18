FROM ubuntu:trusty

RUN    apt-get update \
    && apt-get install -qqy \
        apt-transport-https \
        ca-certificates \
        curl \
        lxc \
        iptables \
        gnupg-agent \
        software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
        "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
        $(lsb_release -cs) \
        stable" \
    && apt-get update

RUN apt-get install -qqy docker-ce=17.03.2~ce-0~ubuntu-trusty

# Install the magic wrapper.
ADD ./wrapdocker /usr/local/bin/wrapdocker
RUN chmod +x /usr/local/bin/wrapdocker

# Add the containre prepopulation script
ADD populate.sh /usr/local/bin/populate.sh

# Define additional metadata for our image.
VOLUME /var/lib/docker
CMD ["wrapdocker"]
