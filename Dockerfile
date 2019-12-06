from python:3.8.0-slim-buster

VOLUME /config
WORKDIR /config

COPY ./default.conf /config/.

RUN apt-get update && \
    apt-get install -y python3 python3-dev python3-pip git

RUN pip3 install -y pip3 install deepspeechi deepspeech-server

WORKDIR /usr/srv/deepsearch
# Download pre-trained English model and extract
RUN curl -LO https://github.com/mozilla/DeepSpeech/releases/download/v0.6.0/deepspeech-0.6.0-models.tar.gz && \
    tar xvf deepspeech-0.6.0-models.tar.gz

# Download example audio files
RUN curl -LO https://github.com/mozilla/DeepSpeech/releases/download/v0.6.0/audio-0.6.0.tar.gz && \
    tar xvf audio-0.6.0.tar.gz

 CMD ["deepspeech-server", "--config", "/config/config.json"]
