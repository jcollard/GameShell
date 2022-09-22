from debian:stable

###
# install dependencies
RUN apt update
RUN apt install --no-install-recommends --assume-yes \
    ca-certificates \
    wget \
    locales \
    gettext \
    man-db \
    psmisc \
    procps \
    nano \
    tree \
    bsdmainutils \
    x11-apps
RUN apt clean
RUN rm -rf /var/lib/apt/lists/*

###
# install locales and set default
RUN sed -i 's/^# *\(en_US.UTF-8\)/\1/' /etc/locale.gen
RUN sed -i 's/^# *\(fr_FR.UTF-8\)/\1/' /etc/locale.gen
RUN locale-gen
RUN update-locale LANG=en_US.UTF-8
ENV LANG en_US.UTF-8

###
# set user and group
ARG user=gsh-user
ARG group=gsh-user
ARG uid=1000
ARG gid=1000
RUN groupadd -g ${gid} ${group} && \
    useradd -u ${uid} -g ${group} -s /bin/sh -m ${user} && \
    mkdir /home/gsh-user/GameShell && \
    chown gsh-user:gsh-user /home/gsh-user/GameShell
VOLUME ["/home/gsh-user/GameShell"]


###
# switch to user
USER ${uid}:${gid}
WORKDIR /home/${user}


### use the latest github version
ADD entry.sh /home/${user}/entry.sh


### if you prefer to use a local customized version, comment the preceeding
### ADD ...
### line and uncomment the next one
### (NOTE that you need to have generated a "gameshell.sh" file with GSH_ROOT/utils/archive.sh
# COPY gameshell.sh .

ENTRYPOINT ["bash", "./entry.sh"]
