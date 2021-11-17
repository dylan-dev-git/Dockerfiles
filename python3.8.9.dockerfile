FROM ubuntu:bionic

RUN apt-get update && apt-get install -y build-essential autoconf automake gdb git libffi-dev zlib1g-dev libssl-dev curl vim sudo wget

RUN useradd -m -u 1000 -s /bin/bash -d /home/dylan dylan
RUN echo 'dylan ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Python v3.8.9 install. 
RUN set -x \
  && cd /usr/src \
  && wget https://www.python.org/ftp/python/3.8.9/Python-3.8.9.tgz \
  && tar xzf Python-3.8.9.tgz \
  && cd Python-3.8.9 \
  && ./configure --enable-optimizations \
  && make altinstall \
  && rm -f /usr/src/Python-3.8.9.tgz \
  && ln -s /usr/local/bin/python3.8 /usr/bin/python3.8 \
  && ln -s /usr/local/bin/pip3.8 /usr/bin/pip3.8 

USER dylan
WORKDIR /home/dylan
RUN python3.8 -m venv env