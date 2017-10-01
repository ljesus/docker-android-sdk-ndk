FROM openjdk:8-jdk

MAINTAINER Nick Petrovsky <nick.petrovsky@gmail.com>

RUN useradd -u 1000 -M -s /bin/bash android
RUN chown 1000 /opt

USER android

ENV ANDROID_COMPILE_SDK "25"
ENV ANDROID_BUILD_TOOLS "26.0.2"
ENV ANDROID_SDK_TOOLS_REV "4333796"
ENV ANDROID_CMAKE_REV "3.6.4111459"

ENV ANDROID_HOME=/opt/android-sdk-linux
ENV ANDROID_NDK_HOME ${ANDROID_HOME}/ndk-bundle
ENV PATH ${PATH}:${ANDROID_HOME}/platform-tools/:${ANDROID_NDK_HOME}

RUN mkdir -p ${ANDROID_HOME}/licenses
RUN echo Cjg5MzNiYWQxNjFhZjQxNzhiMTE4NWQxYTM3ZmJmNDFlYTUyNjljNTU= | base64 -d >                                                                                                                                                              ${ANDROID_HOME}/licenses/android-sdk-license
RUN wget --quiet --output-document=${ANDROID_HOME}/android-sdk.zip https://dl.go                                                                                                                                                             ogle.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS_REV}.zip
RUN unzip -qq ${ANDROID_HOME}/android-sdk.zip -d ${ANDROID_HOME}
RUN rm ${ANDROID_HOME}/android-sdk.zip

RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager --update
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'tools'
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'platform-tools'
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'build-tools;'$ANDROID_BUILD_TOO                                                                                                                                                             LS
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'platforms;android-'$ANDROID_COM                                                                                                                                                             PILE_SDK
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'extras;android;m2repository'
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'extras;google;google_play_servi                                                                                                                                                             ces'
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'extras;google;m2repository'
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'cmake;'$ANDROID_CMAKE_REV
RUN echo y | $ANDROID_HOME/tools/bin/sdkmanager 'ndk-bundle'

VOLUME ["/opt/android-sdk-linux"]