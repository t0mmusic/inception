NAME =	./srcs/docker-compose.yml

IMAGES = srcs_wordpress srcs_nginx srcs_mariadb srcs_redis srcs_adminer 
CONTAINERS = wordpress nginx mariadb redis adminer
NETWORKS = srcs_lemp
VOLUMES = srcs_mariadb_data srcs_wordpress_data

all:
	docker-compose -f $(NAME) up -d --build

down:
	@docker-compose -f $(NAME) down

re: clean all

clean:
	@docker stop $(CONTAINERS);\
	docker rm $(CONTAINERS);\
	docker rmi -f $(IMAGES);\
	docker volume rm --force $(VOLUMES);\
	docker network rm $(NETWORKS);\

fclean: clean
	rm -rf /home/${USER}/data

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

ash:
	docker exec -it adminer bash

rsh:
	docker exec -it redis bash

.PHONY: all re down clean fclean