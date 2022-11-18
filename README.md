# Build docker container

```shell
docker build -t flux-psij -f docker/flux-psij.dockerfile .
```

# Start the execution

```shell
docker run --rm -it flux-psij bash

flux start
python3.7 /home/fluxuser/hello-flux-container.py
```

# Start the execution using `docker compose`

```shell
cd docker
docker compose up -d
# stop services (flux-psij and flux-extra)
#   docker compose stop

docker exec -it flux-psij bash

# start with 2 brokers (services in docker-compose)
flux start -o,--config-path=/home/fluxuser,-Sbroker.quorum-timeout=2s
# check list of resources
flux resource list

# FIXME: flux doesn't see another host (flux-extra)

python3.7 /home/fluxuser/hello-flux-container.py
```

