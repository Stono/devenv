FROM centos:centos7
MAINTAINER Karl Stoney <me@karlstoney.com>

# Disable the annoying fastest mirror plugin
RUN sed -i '/enabled=1/ c\enabled=0' /etc/yum/pluginconf.d/fastestmirror.conf

# Set the environment up
ENV TERM xterm-256color

# Install the EPEL repository and do a yum update
RUN yum -y -q install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
    yum -y -q update && \
    yum -y -q install squid curl && \
    yum -y -q clean all

# Create log dirs
RUN mkdir -p /logs && \
    chown -R squid:squid /logs && \
    chmod 0755 /logs

COPY squid.conf /etc/squid/squid.conf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

CMD ["/usr/local/bin/entrypoint.sh"]
