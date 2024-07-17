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

## build docker image
```
cd ~/aic/aic_docker
make build
```

## up docker container from built image (without GPU)
```
cd ~/aic/aic_docker
make up
```

## up docker container from built image (with NVIDIA GPU)
```
cd ~/aic/aic_docker
make gpu-up
```
