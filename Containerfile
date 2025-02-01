FROM ghcr.io/ubiquitous-factory/amrite:main as crunbuild 
FROM ghcr.io/ubiquitous-factory/brog:main as brogbuild 
FROM quay.io/fedora/fedora-bootc:41

## Install systemd-container for debugging
RUN dnf install systemd-container 

## !!! This image is for test purposes only. !!! 
## If you are going into production please contact admin@mehal.tech for a hardened production coras image.
## See https://docs.mehal.tech/coras


RUN pass=$(mkpasswd --method=SHA-512 --rounds=4096 thepassword) && useradd -m -G wheel bootcer -p $pass
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo

######################################################
# First boot configuration
######################################################
WORKDIR /etc
COPY first-boot/first-boot.sh ./
RUN chmod +x /etc/first-boot.sh 
COPY first-boot/first-boot.service /etc/systemd/system
RUN systemctl enable first-boot.service

######################################################
# brog install for OS updates
######################################################
# Disable auto updates as we are going to use brog
RUN systemctl disable bootc-fetch-apply-updates.timer
COPY --from=brogbuild  /brog /usr/bin
COPY brog/brog.service /etc/systemd/system
RUN systemctl enable brog.service

######################################################
# amrite install for wasi support
######################################################

COPY --from=crunbuild /vendor/fedora_41/libwasmedge.so.0 /usr/local/lib64/libwasmedge.so.0 
COPY --from=crunbuild /vendor/fedora_41/crun-wasmedge /usr/bin/crun

######################################################
# quadit install for container deployments
######################################################
RUN setsebool -P container_manage_cgroup true
USER bootcer
WORKDIR /home/bootcer/.quadit
COPY quadit/quadit.yaml ./
WORKDIR /home/bootcer/.config/containers/systemd/
COPY quadit/quadit.container ./

# set user to root for boot process
USER root

