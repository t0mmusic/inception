NAME =	srcs/docker-compose.yml

all:
	docker-compose $(NAME) -d

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