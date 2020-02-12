This is the docker-bootstrap config file for https://STC-Rec.TamaToledo.net. My dockerized-server Workflow post describes the server setup too.

Note that `baseURL=stc-rec.tamatoledo.net` in the project's `config.toml` file.

Run the following ONE time on the host...

NAME=stc-rec
HOST="stc-rec.tamatoledo.net"
IMAGE="summittdweller/stc-rec"
docker container run -d --name ${NAME} \
    --label traefik.backend=${NAME} \
    --label traefik.docker.network=web \
    --label traefik.port=80 \
    --label "traefik.frontend.redirect.regex=^http(s)?://(www.)?(${HOST})(.+)" \
    --label "traefik.frontend.redirect.replacement=https://stc-rec.tamatoledo.net$4" \
    --label "traefik.frontend.redirect.permanent=true" \
    --label com.centurylinklabs.watchtower.enable=true \
    --network web \
    --restart always \
    ${IMAGE}

See https://github.com/containous/traefik/issues/2796
