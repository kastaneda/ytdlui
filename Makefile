all: install build

install:
	mkdir downloads
	chmod 0777 downloads
	touch list_todo.txt list_done.txt list_errors.txt
	chmod 0666 list_todo.txt list_done.txt list_errors.txt

build:
	docker build -t ytdlui ./

rebuild:
	docker build -t ytdlui --no-cache ./

.PHONY: all install build rebuild
