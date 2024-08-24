# Use an official Dart base image
FROM ubuntu:20.04

ENV JAVA_VERSION="11"

# Install necessary packages
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    openjdk-$JAVA_VERSION-jdk \
    adb \
    curl \
    unzip \
    sed \
    git \
    wget \
    bash \
    xz-utils \
    libglvnd0 \
    ssh \
    xauth \
    x11-xserver-utils \
    libpulse0 \
    libxcomposite1 \
    libgl1-mesa-glx \
    && rm -rf /var/lib/{apt,dpkg,cache,log}

# Install Flutter
RUN curl -L -o flutter.zip https://storage.googleapis.com/dart-archive/channels/stable/release/3.5.1/sdk/dartsdk-linux-x64-release.zip \
    && unzip flutter.zip -d /flutter \
    && rm flutter.zip \
    && cd /flutter \
    && flutter doctor

# Add Flutter to PATH
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Set up Android SDK environment variables
ENV ANDROID_SDK_ROOT=/usr/lib/android-sdk
ENV PATH="${ANDROID_SDK_ROOT}/tools:${ANDROID_SDK_ROOT}/platform-tools:${PATH}"

# Accept licenses and install Android SDK components
RUN yes | sdkmanager --licenses \
    && sdkmanager "platforms;android-30" "build-tools;30.0.3"

# Copy the Flutter project files
WORKDIR /app
COPY . .

# Install Flutter dependencies
RUN flutter pub get

# Build the Flutter app
RUN flutter build apk --release

# Run adb server
RUN adb start-server

# Default command to run the app
CMD ["flutter", "run"]

# Expose ports for ADB
EXPOSE 5554 5555
