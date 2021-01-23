#!/bin/bash

docker pull gitlab/gitlab-ce:13.8.0-ce.0

https://docs.gitlab.com/omnibus/docker/

export GITLAB_HOME=/srv/gitlab

docker run --detach \
  --hostname 127-0-0-1.nip.io \
  --publish 443:443 --publish 80:80 --publish 22:22 \
  --name gitlab \
  --volume $GITLAB_HOME/config:/etc/gitlab \
  --volume $GITLAB_HOME/logs:/var/log/gitlab \
  --volume $GITLAB_HOME/data:/var/opt/gitlab \
  gitlab/gitlab-ce:13.8.0-ce.0

docker logs -f gitlab | grep "gitlab Reconfigured"

# https://127-0-0-1.nip.io
