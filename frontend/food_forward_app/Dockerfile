# Use the official Dart image with Dart SDK 3.x
FROM dart:stable AS build

# Set the working directory
WORKDIR /app

# Copy the current directory contents into the container
COPY . .

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"

# Install dependencies
RUN flutter pub get

# Run the app
CMD ["flutter", "build", "apk"]
