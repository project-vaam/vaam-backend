#!/bin/sh
mvn install && java -jar target/ncfinder-1.0.0-SNAPSHOT.jar server config.yml