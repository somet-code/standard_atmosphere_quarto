ARG PYTHON_VERSION=3.14.0
FROM python:${PYTHON_VERSION}-slim-bookworm

COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir --upgrade pip && \
    python3 -m pip install --no-cache-dir -r requirements.txt

# https://github.com/quarto-dev/quarto-cli/pkgs/container/quarto
ARG QUARTO_VERSION=1.8.25

RUN apt-get update && apt-get install -y \
    curl

RUN mkdir -p /opt/quarto/${QUARTO_VERSION} && \
    curl -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz -o /opt/quarto/${QUARTO_VERSION}/quarto.tar.gz && \
    tar -xzf /opt/quarto/${QUARTO_VERSION}/quarto.tar.gz -C /opt/quarto/${QUARTO_VERSION} --strip-components=1 && \
    rm /opt/quarto/${QUARTO_VERSION}/quarto.tar.gz && \
    ln -s /opt/quarto/${QUARTO_VERSION}/bin/quarto /usr/local/bin/quarto

RUN quarto check

WORKDIR /app

EXPOSE 8888

ENTRYPOINT ["jupyter", "lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]

# http://localhost:8889
# docker compose up -d
# docker exec -it ussa1976 bas
# jupyter server list to get token
# http://localhost:8889