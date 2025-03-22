#! /bin/bash

BOOTC_USER=bootcer

systemctl --user enable --now podman 
# ensure constiner services survive reboot
loginctl enable-linger ${BOOTC_USER}

# login as user to enable and start quadit
machinectl shell --uid ${BOOTC_USER}
systemctl --user enable --now quadit
