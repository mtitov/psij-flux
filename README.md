# Flux testing environment for PSI/J

## Build docker container

```shell
./docker/build.sh
```

## Start execution

```shell
docker run --rm -it exaworks/flux-psij bash

flux start
python3.7 /home/fluxuser/workdir/hello-flux-container.py
```

## Start execution using `docker compose` (multi-broker)

```shell
cd docker

docker compose up -d
# stop containers (flux-psij and flux-sched)
#   docker compose stop
# remove containers
#   docker compose rm -f

docker exec -it flux-psij bash

# start with 2 brokers (services in docker-compose)
flux start -o,-Sbroker.quorum-timeout=2s
# check list of resources
#   flux resource list
python3.7 /home/fluxuser/workdir/hello-flux-container.py
```

