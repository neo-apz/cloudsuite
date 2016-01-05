#!/bin/bash -x

# $1: repo $2: tag $3: path
build() {
    # export REPO=arashpz/data-caching-ci
    # export TAG=`if [ "$TRAVIS_BRANCH" == "master" ]; then echo "latest"; else echo $TRAVIS_BRANCH ; fi`
    docker build -t $1:$2 $3
    docker push $1
}

docker login -e="$DOCKER_EMAIL" -u="$DOCKER_USER" -p="$DOCKER_PASS"
# export REPO=arashpz/data-caching-ci
# export TAG=`if [ "$TRAVIS_BRANCH" == "master" ]; then echo "latest"; else echo $TRAVIS_BRANCH ; fi`
# docker build -t server ./benchmarks/data-caching/server
# docker tag $REPO:$COMMIT $REPO:$TAG
# docker tag $REPO:$COMMIT $REPO:travis-$TRAVIS_BUILD_NUMBER
# docker push $REPO


build "arashpz/data-caching-ci" "server" "./benchmarks/data-caching/server"
build "arashpz/data-caching-ci" "client" "./benchmarks/data-caching/client"
