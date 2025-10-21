ARG PYTHON_VERSION=3.14.0
FROM python:${PYTHON_VERSION}-slim-bookworm

COPY requirements.txt .
RUN python3 -m pip install -r requirements.txt

# Version number of Quarto to download and use
# See https://github.com/quarto-dev/quarto-cli/pkgs/container/quarto for existing versions
ARG QUARTO_VERSION=1.9.8

RUN apt-get update && apt-get install -y \
    curl

RUN mkdir -p /opt/quarto/${QUARTO_VERSION} && \
    curl -L https://github.com/quarto-dev/quarto-cli/releases/download/v${QUARTO_VERSION}/quarto-${QUARTO_VERSION}-linux-amd64.tar.gz -o /opt/quarto/${QUARTO_VERSION}/quarto.tar.gz && \
    tar -xzf /opt/quarto/${QUARTO_VERSION}/quarto.tar.gz -C /opt/quarto/${QUARTO_VERSION} --strip-components=1 && \
    rm /opt/quarto/${QUARTO_VERSION}/quarto.tar.gz && \
    ln -s /opt/quarto/${QUARTO_VERSION}/bin/quarto /usr/local/bin/quarto

RUN /opt/quarto/${QUARTO_VERSION}/bin/quarto check