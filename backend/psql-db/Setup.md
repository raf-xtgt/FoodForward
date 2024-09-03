# First time setup

#### Pull the PostgreSQL Docker Image
```
docker pull postgres:latest
```

#### Step 2: Create a Docker Network 
Create a custom Docker network to allow communication between the PostgreSQL container and your Spring Boot application container:
```
docker network create spring-postgres-network
```


#### Step 3: Run the PostgreSQL Docker Container
```
docker run --name postgres-container --network=spring-postgres-network -e POSTGRES_DB=your_database_name -e POSTGRES_USER=your_username -e POSTGRES_PASSWORD=your_password -p 5432:5432 -d postgres:latest
```
At this point the container is running so we can execute a command in the
docker to access the db.
```
docker exec -it postgres-container psql -U your_username -d your_database_name

```
