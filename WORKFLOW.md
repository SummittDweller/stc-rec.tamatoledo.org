This is the docker-bootstrap config file for the new "static" https://STC-Rec.TamaToledo.org. My `dockerized-server Workflow` post describes the server setup too.

Note that `baseURL=stc-rec.tamatoledo.org` is set in the project's `config.toml` file, but probably has no bearing in this depolyment scheme.

Run the following ONE time on the host...

```
NAME=stc-rec
HOST="stc-rec.tamatoledo.org"
IMAGE="summittdweller/stc-rec"
docker container run -d --name ${NAME} \
    --label traefik.backend=${NAME} \
    --label traefik.docker.network=web \
    --label traefik.port=80 \
    --label "traefik.frontend.rule=Host:${HOST}" \
    --label com.centurylinklabs.watchtower.enable=true \
    --network web \
    --restart always \
    ${IMAGE}
```

See https://github.com/containous/traefik/issues/2796
