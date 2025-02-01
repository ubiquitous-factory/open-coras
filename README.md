# open-coras

A bootc based linux distribution by [Mehal Technologies](https://mehal.tech).

This distribution is intended for developers interested in investigating gitops in a bootc environment.

[![Build Coras bootc image](https://github.com/ubiquitous-factory/open-coras/actions/workflows/build-coras.yaml/badge.svg)](https://github.com/ubiquitous-factory/open-coras/actions/workflows/build-coras.yaml)

Out of the box evaluate the [open gitops scenarios](https://docs.mehal.tech/tutorials) and see if this project maps to your requirements. 

⚠️⚠️⚠️ THIS IMAGE HAS HARDCODED CREDENTIALS AND IS NOT PRODUCTION HARDENED ⚠️⚠️⚠️

For a supported production version of this image please visit - [Mehal Technologies](https://docs.mehal.tech/coras)

If you would like to test this distribution with private repositories and/or complex deployments such as canary releases please refer to [clos](https://docs.mehal.tech/clos).

# usage 

Install [podman-bootc](https://github.com/containers/podman-bootc?tab=readme-ov-file#streamlining-podman--bootc-interactions)
```

podman-bootc run  --filesystem xfs ghcr.io/ubiquitous-factory/open-coras:320b2b999a64fd7b8eb07e34be38f972218d611b
```

For alternatives please see https://docs.mehal.tech/coras

# notes

The user name and password for this image is `bootcer` with `thepassword`. It's obviously recommended that the `bootcer` user is deleted as part of the downstream build. 

For a more robust security posture consider using the supported [coras](https://docs.mehal.tech/coras) distribution.

