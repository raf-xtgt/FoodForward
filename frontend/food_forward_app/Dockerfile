FROM ubuntu:20.04

ENV DEBIAN_FRONTEND="noninteractive"
ENV JAVA_VERSION="11"
ENV ANDROID_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip"
ENV ANDROID_VERSION="33" 
ENV ANDROID_BUILD_TOOLS_VERSION="33.0.0"
ENV ANDROID_ARCHITECTURE="x86_64"
ENV ANDROID_SDK_ROOT="/usr/local/android-sdk"
ENV FLUTTER_CHANNEL="stable"
ENV FLUTTER_VERSION="3.24.1"
ENV GRADLE_VERSION="7.2"
ENV GRADLE_USER_HOME="/opt/gradle"
ENV GRADLE_URL="https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip"
ENV FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/$FLUTTER_CHANNEL/linux/flutter_linux_$FLUTTER_VERSION-$FLUTTER_CHANNEL.tar.xz"
ENV FLUTTER_ROOT="/opt/flutter"
ENV PATH="$ANDROID_SDK_ROOT/cmdline-tools/latest/bin:$ANDROID_SDK_ROOT/emulator:$ANDROID_SDK_ROOT/platform-tools:$ANDROID_SDK_ROOT/platforms:$FLUTTER_ROOT/bin:$GRADLE_USER_HOME/bin:$PATH"

# Install the necessary dependencies.
RUN apt-get update \
  && apt-get install --yes --no-install-recommends \
    openjdk-$JAVA_VERSION-jdk \
    curl \
    adb \
    unzip \
    sed \
    git \
    bash \
    xz-utils \
    libglvnd0 \
    ssh \
    xauth \
    x11-xserver-utils \
    libpulse0 \
    libxcomposite1 \
    libgl1-mesa-glx \
    qemu-kvm \
    libvirt-daemon-system \
    libvirt-dev \
    bridge-utils \
    cmake \
    virt-manager \
    cmake \
    ninja-build \
    gcc \
    g++ \
    clang \
    pkg-config \
    libgtk-3-dev \         
    liblzma-dev \          
    libcurl4-openssl-dev \  
    libssl-dev \            
    libjsoncpp-dev \       
    libsqlite3-dev \         
    libx11-dev \             
    libxcb1-dev \           
    libxrandr-dev \
    libsecret-1-dev \ 
    libjsoncpp-dev \           
  && rm -rf /var/lib/{apt,dpkg,cache,log}

# Install Gradle.
RUN curl -L $GRADLE_URL -o gradle-$GRADLE_VERSION-bin.zip \
  && apt-get install -y unzip \
  && unzip gradle-$GRADLE_VERSION-bin.zip \
  && mv gradle-$GRADLE_VERSION $GRADLE_USER_HOME \
  && rm gradle-$GRADLE_VERSION-bin.zip

# Install the Android SDK.
RUN mkdir /root/.android \
  && touch /root/.android/repositories.cfg \
  && mkdir -p $ANDROID_SDK_ROOT \
  && curl -o android_tools.zip $ANDROID_TOOLS_URL \
  && unzip -qq -d "$ANDROID_SDK_ROOT" android_tools.zip \
  && rm android_tools.zip \
  && mv $ANDROID_SDK_ROOT/cmdline-tools $ANDROID_SDK_ROOT/latest \
  && mkdir -p $ANDROID_SDK_ROOT/cmdline-tools \
  && mv $ANDROID_SDK_ROOT/latest $ANDROID_SDK_ROOT/cmdline-tools/latest \
  && yes "y" | sdkmanager "build-tools;$ANDROID_BUILD_TOOLS_VERSION" \
  && yes "y" | sdkmanager "platforms;android-$ANDROID_VERSION" \
  && yes "y" | sdkmanager "platform-tools" \
  && yes "y" | sdkmanager "emulator" \
  && yes "y" | sdkmanager "system-images;android-$ANDROID_VERSION;google_apis;x86_64"

# Install Flutter.
RUN curl -o flutter.tar.xz $FLUTTER_URL \
  && mkdir -p $FLUTTER_ROOT \
  && tar xf flutter.tar.xz -C /opt/ \
  && rm flutter.tar.xz \
  && git config --global --add safe.directory /opt/flutter 

# Create a non-root user
RUN useradd -ms /bin/bash flutteruser

# Perform initial Flutter setup as root
RUN flutter precache \
  && flutter doctor \
  && flutter config --no-analytics \
  && yes "y" | flutter doctor --android-licenses

# Set environment variables for non-root user
ENV PUB_CACHE="/home/flutteruser/.pub-cache"
ENV FLUTTER_ROOT="/opt/flutter"

# Make sure the non-root user owns the relevant directories
RUN chown -R flutteruser:flutteruser $FLUTTER_ROOT \
  && mkdir -p /home/flutteruser/.pub-cache \
  && chown -R flutteruser:flutteruser /home/flutteruser/.pub-cache

# Switch to the non-root user
USER flutteruser
WORKDIR /home/flutteruser

# Copy and install Flutter dependencies
COPY --chown=flutteruser:flutteruser . /home/flutteruser/app
WORKDIR /home/flutteruser/app

# Install Flutter dependencies
RUN flutter pub get

# # Expose the default Flutter port
# EXPOSE 8000

# # Start adb server and run the Flutter app
# CMD adb start-server && adb connect $ADB_HOST:5555 && flutter run