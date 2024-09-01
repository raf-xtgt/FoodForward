## Load flutter in terminal

```
source ~/.bash_profile
```

## Running the flutter app
```
cd app_name
flutter run
```

## Get a list of available devices
```
flutter devices
```

## Cleaning and rebuilding the project
```
flutter clean
flutter pub get
flutter run
```

## Build the docker image
```
docker build -t food-forward-app .
```

## Run the container
```
docker run -it --rm --name food-forward-container food-forward-app
```

## Run the container and connect to emulator
```
docker run --network="host" -it --rm --name food-forward-container food-forward-app
```

## List running containers
```
docker ps
```

## Stop the container
```
docker stop <container_id_or_name>
```

## List emulators using avd
```
emulator -list-avds
```

## Run emulator
```
emulator -avd Pixel_8_Pro_API_33
```