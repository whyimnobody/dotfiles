# Docker workflow

## Discover

1. `docker version`
2. `docker context ls`
3. `docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}'`

## Validate

1. Build with explicit tag: `docker build -t <name>:<tag> -f <Dockerfile> <context>`
2. Optional multi-platform build check: `docker buildx ls`
3. Inspect built image: `docker image inspect <name>:<tag>`

## Apply

1. Start/update container with explicit config (`--name`, `-p`, `-e`, `-v`).
2. Avoid unnamed containers for infra components.
3. For compose: `docker compose config` before `docker compose up -d`.

## Verify

1. `docker ps`
2. `docker logs --tail 100 <container>`
3. Health checks: `docker inspect --format '{{json .State.Health}}' <container>`

## Common recovery

1. Clean stopped containers: `docker container prune` (only with approval)
2. Remove unused images: `docker image prune -a` (only with approval)
3. Pin image digests for production repeatability.
