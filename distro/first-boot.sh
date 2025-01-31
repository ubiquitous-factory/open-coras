#! /bin/bash

BOOTC_USER=bootcer

# ensure constiner services survive reboot
loginctl enable-linger ${BOOTC_USER}

# login as user to enable and start quadit
machinectl shell --uid ${BOOTC_USER}
systemctl --user enable --now quadit
