# Raspberry PI 4 

Image definition for the [Raspberry Pi 4 and above](https://www.raspberrypi.com/)

Implementation based on: 
https://github.com/ondrejbudai/fedora-bootc-raspi/tree/main and 
https://mrguitar.net/?p=2605

## Notes 

Support for arm64 isn't great on GH actions but to create an bootable SDCard you can use 

* [The Podman Desktop makes life easy section](https://mrguitar.net/?p=2605)

* The cli approach outlined in the [original repo](https://github.com/ondrejbudai/fedora-bootc-raspi/tree/main)
  ```bash
  sudo podman run \
  --rm \
  -it \
  --privileged \
  --pull=newer \
   --security-opt label=type:unconfined_t \
   -v $(pwd)/output:/output \
   -v /var/lib/containers/storage:/var/lib/containers/storage \
   quay.io/centos-bootc/bootc-image-builder:latest \
   --type raw \
   --local \
   --rootfs ext4 \
   ghcr.io/ubiquitous-factory/open-coras-rpi

    # arm-image-installer can deal only deal with xz archives, let's deal with that
    xz -v -0 -T0 output/raw/disk.raw
    # substitute $DISK with the location of Raspberry Pi disk
    sudo arm-image-installer --target=rpi4 --media=$DISK --image output/raw/disk.raw.xz --resizefs
  ```