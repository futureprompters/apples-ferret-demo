# Apples Ferret Demo

## Model weights

Script for model reproduction, i.e. applying delta weights to Vicuna weights is described in [models/ferret-7b-v1-3](./models/ferret-7b-v1-3).

## The demo app

To use the demo run the [app.py](./ferret/app.py).



```
conda create -n ferret python=3.10 -y
conda activate ferret
pip install poetry
poetry install

pre-commit install

ruff check src
ruff format --check src

docker build -t ferret -f ./docker/ferret.Dockerfile .

```