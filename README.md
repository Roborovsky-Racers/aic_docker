# aic_docker

## initial setup
```
curl -O https://raw.githubusercontent.com/Roborovsky-Racers/aic_docker/main/scripts/setup.bash
bash ./setup.bash
rm ./setup.bash
```
OR
```
mkdir -p ~/aic/ && cd ~/aic/
git clone https://github.com/Roborovsky-Racers/aic_docker.git
./scripts/setup.bash
```

## develop
### build dev image
```
make build
```

### up docker container from built image (without GPU)
```
make up
```

### up docker container from built image (with NVIDIA GPU)
```
make gpu-up
```

## evaluation
### use custom configuration (without rocker)
```
make build-eval
make up-eval
(auto attach to container)
./run_evaluation.bash
```

### use official configuration
```
make eval
```

## cleanup docker images
```
make cleanup-images
```
