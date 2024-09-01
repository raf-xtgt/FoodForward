#!/bin/bash

# Connect to the Android emulator container.
adb connect emulator:5555

#List the available Flutter devices. You should see the connected dockerized emulator.
flutter devices

# Install the Flutter packages.
flutter pub get

# Run the Flutter app on the connected emulator.
# Add `--trace-startup` to stop the Flutter process from blocking the terminal.
flutter run --trace-startup

# Step 4: Start the backend service
echo "Starting the backend service..."
BACKEND_CONTAINER_ID=$(docker ps -qf "name=food_forward_backend")
docker exec -it $BACKEND_CONTAINER_ID java -jar /backend/WebServiceApplication/target/WebServiceApplication-0.0.1-SNAPSHOT.jar # Update the path to your JAR file

echo "All services are up and running!"
