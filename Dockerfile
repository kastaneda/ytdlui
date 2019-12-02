# Why I use Ubuntu and not Alpine?
# Because it's much easier for debugging.
FROM ubuntu:latest

# Do it.
RUN apt-get update && \
    apt-get install -y python-pip locales && \
    pip install --upgrade youtube_dl

# Doing proper locale.
# youtube-dl requires this to save non-ASCII chars in filenames.
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LC_ALL en_US.UTF-8

# I use this folder to put downloads here. Why not.
WORKDIR /media
