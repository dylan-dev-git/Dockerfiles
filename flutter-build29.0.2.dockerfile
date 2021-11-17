FROM ubuntu:bionic

RUN apt-get update
RUN apt-get install -y build-essential autoconf automake gdb git libffi-dev zlib1g-dev libssl-dev curl vim sudo wget unzip openjdk-8-jdk

RUN useradd -u 1000 -ms /bin/bash dylan
USER dylan
WORKDIR /home/dylan

RUN mkdir -p Android/sdk/cmdline-tools
RUN mkdir -p .android && touch .android/repositories.cfg
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-7302050_latest.zip
RUN unzip sdk-tools.zip -d Android/sdk/cmdline-tools && rm sdk-tools.zip
RUN mv Android/sdk/cmdline-tools/cmdline-tools Android/sdk/cmdline-tools/latest
ENV ANDROID_HOME /home/dylan/Android/sdk

RUN cd Android/sdk/cmdline-tools/latest/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/cmdline-tools/latest/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools:$PATH"

RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/dylan/flutter/bin"
RUN flutter doctor
RUN mkdir -p myflutter
