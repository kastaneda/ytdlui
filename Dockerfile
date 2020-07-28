FROM ubuntu:latest

RUN apt-get update && \
    apt-get install -y python-pip locales && \
    pip install --upgrade youtube_dl

# youtube-dl requires locale to save non-ASCII chars in filenames.
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LC_ALL en_US.UTF-8

WORKDIR /downloads
