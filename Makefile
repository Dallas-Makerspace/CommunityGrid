STACK_NAME		:= $(shell basename "$$(pwd)")
STACK_FILES		:= $(addprefix -c ./,$(wildcard *.yml))
DOMAIN			:= dms.local
DTR_AUTH		:= 'dtr:$$$$apr1$$$$9Cv/OMGj$$$$ZomWQzuQbL.3TRCS81A1g/'
IMAGES			:= $(shell cat $(wildcard *.yml) | awk '/image:/ { print $$(NF) }')

export DOMAIN
export DTR_AUTH

.DEFAULT: all
.PHONY: all clean test deploy

all: clean deploy 

clean:
	@docker stack rm $(STACK_NAME)

test:
	@docker-compose config -q

scan:
	@docker image ls | awk '/ago/ { system("docker run --rm -v //var/run/docker.sock://var/run/docker.sock actuary "$$3); }'

report:
	@docker service ls | awk '/$(STACK_NAME)/'

logs:
	@![ -z "$(SERVICE_ID)" ] && docker service $@ $(SERVICE_ID) || echo "Usage: make SERVICE_ID=... $@"

pull:
	@echo $(IMAGES)

deploy: test pull
	@docker stack deploy $(STACK_FILES) $(STACK_NAME)
