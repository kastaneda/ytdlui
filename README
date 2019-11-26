Local video cache
=================

Small web UI for the amazing _youtube-dl_ app.
For some reasons (kinda paranoia), the downloader is running containerized.

Building Docker image
---------------------

```sh
docker build -t ytdl ./
```

or

```sh
docker build -t ytdl --no-cache ./
```

Install
-------

```sh
mkdir -m777 downloads

touch list_todo.txt list_done.txt list_errors.txt
chmod 0666 list_todo.txt list_done.txt list_errors.txt
```

Cronjob
-------

```sh
crontab -e
```

```crontab
*/10 * * * * /var/www/vhosts/ytdl.localhost/cronjob
```

Bookmarklet
-----------

```js
javascript:window.location="http://ytdl.localhost/ui.php?url="+encodeURIComponent(window.location.href);
```
