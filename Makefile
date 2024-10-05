# build base image

IMAGE=$(shell printf 'aic' | xxd -p)

up:
	docker compose up dev -d
	@code --folder-uri vscode-remote://attached-container+$(IMAGE)/aichallenge/workspace/ -d
	@echo ">> entering container with tmux..."
	@docker exec -it aic /usr/bin/tmux
	docker compose down
gpu-up:
	docker compose -f ./docker-compose.yml -f ./docker/nvidia.yml up dev -d
	@code --folder-uri vscode-remote://attached-container+$(IMAGE)/aichallenge/workspace/ -d
	@echo ">> entering container with tmux..."
	@docker exec -it aic /usr/bin/tmux
	docker compose down
up-livox:
	docker compose -f ./docker-compose.livox.yml up
up-eval:
	docker compose up eval -d
	@echo ">> entering container with tmux..."
	@docker exec -it aic /usr/bin/tmux
	docker compose down

down:
	docker compose down

build:
	docker compose build dev-base
	docker compose build dev
build-livox:
	mkdir -p ./PCD
	mkdir -p ./rosbags
	docker compose -f ./docker-compose.livox.yml build
build-eval:
	@cd ../aichallenge-2024 \
		&& rm ./submit/aichallenge_submit.tar.gz \
		&& ./create_submit_file.bash
	@mkdir -p ./submit/ \
		&& cp ../aichallenge-2024/submit/aichallenge_submit.tar.gz ./submit/
	@mkdir -p ./aichallenge/simulator/ \
		&& cp -r ../aichallenge-2024/aichallenge/simulator/AWSIM/ ./aichallenge/simulator/
	docker compose build eval-base
	docker compose build eval
	@rm -rf ./submit/
	@rm -rf ./aichallenge/

eval:
	cd ../aichallenge-2024 \
	&& python3 -m venv .venv \
	&& . .venv/bin/activate \
	&& pip install rocker \
	&& rm ./submit/aichallenge_submit.tar.gz \
	&& ./create_submit_file.bash \
	&& ./docker_build.sh eval \
	&& ./docker_run.sh eval cpu

cleanup-images:
	./scripts/cleanup_docker_images.bash