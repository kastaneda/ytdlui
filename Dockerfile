FROM python:alpine

# RUN pip install youtube_dl && apk add ffmpeg
RUN pip install -U yt-dlp && apk add ffmpeg && mkdir /downloads

WORKDIR /downloads
