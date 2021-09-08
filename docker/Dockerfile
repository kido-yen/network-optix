FROM ubuntu:20.04
# Takes the customization and applies it as a build ARG and an ENV so it can be passed to the entrypoint

# This will override our EULA check.
ENV DEBIAN_FRONTEND noninteractive

# use --build-arg mediaserver_deb= cust= for customization
ARG mediaserver_deb=nxwitness-server-linux64.deb
ARG cust=networkoptix
ENV CUSTOMIZATION ${cust:-networkoptix}

# copy needed files to container
COPY entrypoint.sh /opt
COPY "${mediaserver_deb}" /opt


# Install the mediaserver and configure sudoer

RUN apt-get update \
    && apt-get install -y sudo /opt/${mediaserver_deb} || true \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/ \
    && rm -f /opt/${mediaserver_deb} \
    && echo "${cust} ALL = NOPASSWD: /opt/${cust}/mediaserver/bin/entrypoint.sh, /opt/${cust}/mediaserver/bin/root-tool-bin, /opt/${cust}/mediaserver/bin/mediaserver-bin" > /etc/sudoers.d/${cust} 

# Set the user to run the commands to the networkoptix user created on installation
USER ${CUSTOMIZATION}

# Runs the media server and root-tool on container start
ENTRYPOINT ["/bin/sh", "-c", "/opt/entrypoint.sh ${CUSTOMIZATION}"]
