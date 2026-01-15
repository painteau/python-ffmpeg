# python-ffmpeg

Image Docker de base basée sur `python:slim` avec `ffmpeg`, `Flask` et `Gunicorn`.

Cette image est pensée comme un socle réutilisable pour des API ou applications web Python qui ont besoin de ffmpeg et qui tournent derrière Gunicorn.

## Contenu de l’image

- Base : `python:slim` (dernière version stable de Python)
- Packages système :
  - `ffmpeg`
- Packages Python :
  - `flask`
  - `gunicorn`

## Dockerfile

Le Dockerfile de cette image ressemble à ceci :

```dockerfile
FROM python:slim
ENV PYTHONUNBUFFERED=1

WORKDIR /app
RUN apt-get update \
    && apt-get install -y --no-install-recommends ffmpeg \
    && pip install flask gunicorn \
    && rm -rf /var/lib/apt/lists/*
```

## Architectures supportées

Cette image est construite multi-architecture et supporte :

- **amd64** : PC standard, serveurs Intel/AMD
- **arm64** : Raspberry Pi récents (3/4/5 64-bit), Apple Silicon (M1/M2/M3), AWS Graviton
- **arm/v7** : Anciens Raspberry Pi (32-bit)

## Build manuel

### Build standard (architecture locale)

```bash
docker build -t ghcr.io/painteau/python-ffmpeg:latest .
```

### Build Multi-Arch (si vous voulez builder vous-même pour toutes les plateformes)

Assurez-vous d'avoir activé `buildx` :

```bash
docker buildx create --use
docker buildx build --platform linux/amd64,linux/arm64,linux/arm/v7 -t ghcr.io/painteau/python-ffmpeg:latest --push .
```
Adapte le tag à ton propre registre ou namespace si besoin.

## Utilisation directe

Pour lancer un conteneur interactif basé sur l’image :

```bash
docker run --rm -it ghcr.io/painteau/python-ffmpeg:latest bash
```

## Utilisation comme image de base

Dans un autre projet, tu peux réutiliser cette image comme base :

```dockerfile
FROM ghcr.io/painteau/python-ffmpeg:latest

WORKDIR /app
COPY . .

CMD ["gunicorn", "-b", "0.0.0.0:8000", "app:app"]
```

Ici `app:app` correspond au module et à l’instance Flask de ton application.

## Licence

Ce projet est distribué sous licence MIT. Voir le fichier `LICENSE`.

