all: install build

install:
	mkdir -p downloads
	chmod 0777 downloads
	touch list_todo.txt list_done.txt list_errors.txt
	chmod 0666 list_todo.txt list_done.txt list_errors.txt

build:
	docker build -t kastaneda/ytdlui ./

rebuild:
	docker build -t kastaneda/ytdlui --no-cache ./

restart:
	cat list_errors.txt >> list_todo.txt
	touch list_tmp
	chmod --reference=list_errors.txt list_tmp
	mv list_tmp list_errors.txt

.PHONY: all install build rebuild restart
