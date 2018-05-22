# CommunityGrid
VCC Community Grid at Dallas Makerspace



### Service Deployment
## Add services with deploy labels, (many hosts with Host: or special rules with ';', 
## multiport is traefik.<service_name>.port:

       # - "traefik.frontend.rule=Host:communitygrid.dms.local,communitygrid.dallasmakerspace.org"
       # - "traefik.frontend.priority=0
       # - "traefik.enable=true"
       # - "traefik.port=${PORT}"
       # - "traefik.docker.network=CommunityGrid_gateway"
       # - "traefik.acme.domains=service.communitygrid.dallasmakerspace.org"
       # - "com.centurylinklabs.watchtower.enable"
