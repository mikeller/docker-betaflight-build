FROM ubuntu
MAINTAINER mikeller

# If you want to tinker with this Dockerfile on your machine do as follows:
# - git clone https://github.com/mikeller/docker-betaflight-build.git
# - vim docker-betaflight-build/Dockerfile
# - docker build -t betaflight-build docker-betaflight-build
# - cd <your betaflight source dir>
# - docker run --rm -ti -v `pwd`:/opt/betaflight betaflight-build

RUN apt-get update -y && apt-get install -y git make gcc-arm-none-eabi
RUN mkdir /opt/betaflight
WORKDIR /opt/betaflight

# Config options you may pass via Docker like so 'docker run -e "<option>=<value>"':
# - PLATFORM=<name>, specify target platform to build for
#   Specify 'ALL' to build for all supported platforms. (default: NAZE)
#
# What the commands do:
CMD if [ -z ${PLATFORM} ]; then \
      PLATFORM="NAZE"; \
    fi && \
    if [ ${PLATFORM} = ALL ]; then \
        make clean_all && \
        make all; \
    else \
        make clean TARGET=${PLATFORM} && \
        make ${PLATFORM}; \
    fi
