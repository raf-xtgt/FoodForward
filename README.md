# FoodForward
Households often waste significant amounts of food, while many individuals face hunger. The FoodForward Android application aims to connect near-expiry groceries with NGOs and non-profit organizations that support homeless and vulnerable populations.

FoodForward utilizes generative AI to streamline the process of reading grocery receipts, creating an inventory of food items without the complexity of OCR. Users can filter their inventory into three categories: fresh, near-expiry, and expired. They can select items to receive AI-generated recipes, which can be saved, printed, or reviewed.

Additionally, users can donate near-expiry items to NGOs and non-profits, effectively reducing food waste while addressing hunger and fostering a sustainable community.

The application leverages Google's Gemini API for inventory generation and recipe suggestions. The backend APIs are developed using Java Spring Boot, while the frontend is built with Flutter. The AI engine was developed using NVIDIA AI Workbench, with functionality accessed via Flask APIs through a Python Docker container. The backend is developed with Java Spring Boot, and the frontend utilizes Flutter.

## Setup

### Pull the PostgreSQL Docker Image
```
docker pull postgres:latest
```

### Create a Docker Network 
Create a custom Docker network to allow communication between the PostgreSQL container and your Spring Boot application container:
```
docker network create spring-postgres-network
```

### Run the PostgreSQL Docker Container
```
docker run --name postgres-container --network=spring-postgres-network -e POSTGRES_DB=dev_tenant -e POSTGRES_USER=dev_user -e POSTGRES_PASSWORD=ff20241017 -p 5432:5432 -d postgres:latest
```
At this point the container is running so we can execute a command in the
docker to access the db.


### Run the PostgreSQL Docker Container
```
docker run --name postgres-container --network=spring-postgres-network -e POSTGRES_DB=dev_tenant -e POSTGRES_USER=dev_user -e POSTGRES_PASSWORD=ff20241017 -p 5432:5432 -d postgres:latest
```

### Acess the database
At this point the container is running so we can execute a command in the
docker to access the db.
```
docker exec -it postgres-container psql -U your_username -d your_database_name
```

## Running the AI Engine
### Move into the gen-ai folder
```
cd gen-ai
```

### Build docker image
```
docker build -t food-forward-gen-ai-engine .
```

### Run docker container
```
docker run -it --rm food-forward-gen-ai-engine
```


## Running the BE Server locally
Use an IDE
```
Make use of an IDE preferrably IntelliJ to run the server
```

## Run the Frontend

### Move into the folder
```
cd frontend/food_forward_app/
```

### Install the dependencies
```
flutter clean
flutter pub get
```

### Launch the emulators
Replace with your existing emulator
```
flutter emulators --launch Pixel_8_Pro_API_33
```

### Launch the app
```
flutter run
```

## Demo Video
[![IMAGE ALT TEXT HERE](https://i9.ytimg.com/vi_webp/voLiNnZt2SQ/sddefault.webp?v=66fdc7ab&sqp=CID6hLgG&rs=AOn4CLA6cUlqjLgMl0UjbsafSnAAianMdg)](https://www.youtube.com/watch?v=voLiNnZt2SQ)
