NAME =	./srcs/docker-compose.yml

IMAGES = srcs-wordpress srcs-nginx srcs-mariadb
CONTAINERS = wordpress nginx mariadb
NETWORKS = srcs_lemp
VOLUMES = srcs_mariadb_data srcs_wordpress_data

all:
	docker-compose -f $(NAME) up -d --build

down:
	@docker-compose -f $(NAME) down

re: clean
	@docker compose -f $(NAME) up -d --build

clean:
	@docker stop $(CONTAINERS);\
	docker rm $(CONTAINERS);\
	docker rmi -f $(IMAGES);\
	docker volume rm $(VOLUMES);\
	docker network rm $(NETWORKS);\

prep:
	source ./srcs/tools/phpversion.sh

git:
	@git remote set-url origin https://github.com/t0mmusic/inception.git
	@clear
	@git add .
	@echo "commit msg"
	@read COMMIT; \
	git commit -m "$$COMMIT"; \
	git push;
	@git remote set-url origin git@vogsphere.42adel.org.au:vogsphere/intra-uuid-ebb15778-4a8b-4fd9-942c-ad7e1e7e0390-4566256-jbrown
	git push;

nsh:
	docker exec -it nginx bash

msh:
	docker exec -it mariadb bash

wsh:
	docker exec -it wordpress bash

.PHONY: all re down clean fclean