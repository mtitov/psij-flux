# Build docker container

```shell
docker build -t psij_flux -f docker/psij-flux.dockerfile .
```

# Start the execution

```shell
docker run --rm -it psij_flux bash

flux start
python3.7 /home/fluxuser/hello-flux-container.py
```
