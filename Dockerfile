FROM python:alpine

RUN pip install youtube_dl

WORKDIR /downloads
