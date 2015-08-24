#
# Zolertia Dockerfile
#
# Brief   : Zolertia work environment
# Author  : Antonio Lignan <alinan@zolertia.com>
# Version : v.1.0.0
# Date    : 22/08/2015
# Tested  : Windows 7.
#
# Setup:
# 1. install docker (or docker toolbox).
# 1.1. Windows only, if problems, read:
#      https://docs.docker.com/installation/windows/
#      https://developer.ibm.com/bluemix/2015/04/16/installing-docker-windows-fixes-common-problems/
# 2. docker build -t zolertia/dockerbuild .
#
# Usage:
# 
# About image:
# Ubuntu 14.04 with ARM Cortex-M3 and MSP430X support

# Base machine
FROM ubuntu:trusty
MAINTAINER Antonio Lignan <alinan@zolertia.com> (@4li6NaN)

# Provisioning
ENV DEBIAN_FRONTEND noninteractive
RUN echo "deb http://ppa.launchpad.net/terry.guo/gcc-arm-embedded/ubuntu trusty main" > /etc/apt/sources.list.d/gcc-arm-embedded.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-key FE324A81C208C89497EFC6246D1D8367A3421AFB
RUN apt-get update && apt-get -y dist-upgrade
RUN apt-get -y install \
    build-essential \
	automake \
	gettext \
	gcc-arm-none-eabi \
    curl \
    git \
    graphviz \
    unzip \
    wget \
	gcc \
    gcc-msp430

# Cooja dependencies (optional)
RUN apt-get -y install \
	openjdk-7-jdk \
	openjdk-7-jre \
	ant \

# Nice to have (optional)
RUN apt-get -y install \
    python \
    python3 \
	python-pip \
	nodejs \

# Clean-up
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
	
# Setup
RUN mkdir -p /zolertia
RUN git clone --recursive https://github.com/contiki-os/contiki.git /zolertia/contiki
RUN git clone --recursive https://github.com/RIOT-OS/RIOT.git /zolertia/RIOT
WORKDIR /zolertia

# Default port of UDP examples
EXPOSE 1234
EXPOSE 5678

# Default CoAP port
EXPOSE 5683

# CoAP port to increase header compression efficiency in 6LoWPANs
EXPOSE 61616