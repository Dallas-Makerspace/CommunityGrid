# CommunityGrid

VCC Community Grid at Dallas Makerspace. 

Project goals: build a platform as a service that any makerspace can use. Its as simple to setup for running anything in docker, anywheres.

Includes portainer, tick stack, auto scaling, auto upgrading, traefik based networking.


To expand the cluster build the new boot2docker vm, join the swarm cluster, deploy this to the master.

Global deployments are setup so once the hardware is available it should auto setup on additonal machines.


Key things to note.

## Service Deployment - deploying services / FaaS tasks/ etc..

## Add services with deploy labels, (many hosts with Host: or special rules with ';', 
## multiport is traefik.<service_name>.port:

       # - "traefik.frontend.rule=Host:communitygrid.dms.local,communitygrid.dallasmakerspace.org"
       # - "traefik.frontend.priority=10
       # - "traefik.enable=true"
       # - "traefik.port=${PORT}"
       # - "traefik.docker.network=public"
       # - "traefik.acme.domains=service.communitygrid.dallasmakerspace.org"
       # - "com.centurylinklabs.watchtower.enable='true'"
       # - "orbiter=enabled"
       # - "orbiter.up=3"
       # - "orbiter.down=1"



Include the followling labels at deployment:

```
orbiter: true
orbiter.up: #
orbiter.down: # <should match repication number>
com.centurylinklabs.watchtower.enable: "true"
traefik.enable: true
traefik.frontend.priority: 10
traefik.frontend.rule: Host:...
```

## Setup

```
docker-machine -d generic create ...
docker-machine ssh ... docker swarm init
eval $(docker-machine env ...)
```

## Deploy

``` docker stack deploy -f docker-compose.yml $(basename $(pwd)) ```

## Reconfiguring

... make changes ...

```
docker stack rm $(basename $(pwd)) && \
docker stack deploy -f docker-compose.yml $(basename $(pwd))
```
