FROM ubuntu:24.04
# Takes the customization and applies it as a build ARG and an ENV so it can be passed to the entrypoint

# This will override our EULA check.
ENV DEBIAN_FRONTEND=noninteractive

# use --build-arg mediaserver_deb= cust= for customization
ARG mediaserver_deb=nxwitness-server-linux64.deb
ARG mediaserver_deb_url=https://updates.networkoptix.com/default/41290/linux/nxwitness-server-6.0.5.41290-linux_x64.deb
ARG cust=networkoptix
ENV CUSTOMIZATION=${cust:-networkoptix}

# copy needed files to container
COPY entrypoint.sh /opt
#COPY "${mediaserver_deb}" /opt


# Install the mediaserver and configure sudoer
RUN useradd ${CUSTOMIZATION} && apt update \
    && apt install -y curl sudo \
    && curl ${mediaserver_deb_url} -o /tmp/${mediaserver_deb} \
    && apt install -y /tmp/${mediaserver_deb} || true \
    && apt clean \
    && rm -rf /var/lib/apt/lists/ \
    && rm -f /tmp/${mediaserver_deb} \
    && echo "${cust} ALL = NOPASSWD: /opt/entrypoint.sh, /opt/${cust}/mediaserver/bin/root-tool, /opt/${cust}/mediaserver/bin/mediaserver" > /etc/sudoers.d/${cust}

# Set the user to run the commands to the networkoptix user created on installation
USER ${CUSTOMIZATION}

# Runs the media server and root-tool on container start
ENTRYPOINT ["/bin/bash", "-c", "/opt/entrypoint.sh ${CUSTOMIZATION}"]
