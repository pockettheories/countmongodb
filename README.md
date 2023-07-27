# Approximation Demo

Provides a demo of the approximation schema design pattern in MongoDB

Assume we want to count the number of coin tosses. 

The coin has an equal probability of giving us a head or a tail, and these are the only two possible outcomes.

To halve the number of database writes, we decide that we will add 2 to the count if we see a head, and will not perform any database operation if we see a tail. This will give us a fair estimation of the number of coin tosses.

We can apply this concept to web page visitor counting - we will generate a random number from 1 to 10, and we only perform an increment-by-10 if we the random number generated is 10 (perform no write operations if the random number is not 10). This reduces the write workload to a one-tenth of the normal write workload.

## Instructions

### With a local MongoDB instance

(1) Run mongod on localhost (create a directory, and execute this within the new directory)
```
mongod --dbpath .
```

(2) Execute: 
```
docker run -it pockettheories/countmongodb
```
...or, an alternative for (2) is 
```
git clone https://github.com/pockettheories/countmongodb.git
cd countmongodb
./build.sh && ./runme.sh
```

### Without a local MongoDB instance

```
git clone https://github.com/pockettheories/countmongodb.git
cd countmongodb
docker-compose up -d
docker logs countmongodb-app-1
```
