FROM ubuntu:bionic

RUN apt-get -q update && \
    apt-get install -qy python-pip locales && \
    pip install --upgrade youtube_dl && \
    apt-get clean && \
	rm -rf /var/cache/* /var/log/apt/* /var/lib/apt/lists/* /tmp/*

# youtube-dl requires locale to save non-ASCII chars in filenames.
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen
ENV LC_ALL en_US.UTF-8

WORKDIR /downloads
