# Extends the myoung34/github-runner base with the extra tools our deploy
# workflows need inside the container: the docker CLI (to talk to the
# host's mounted docker.sock) and rsync (frontend build sync).
FROM docker:cli AS dockercli

FROM myoung34/github-runner:latest
COPY --from=dockercli /usr/local/bin/docker /usr/local/bin/docker
RUN apt-get update \
    && apt-get install -y --no-install-recommends rsync \
    && rm -rf /var/lib/apt/lists/*
