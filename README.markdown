Local video cache
=================

Small web UI for the amazing [`youtube-dl`][1] app.
For some reasons (kinda paranoia), the downloader is running containerized.

There is PHP all-in-one script `ui.php` and shell script `cronjob`.
Obviously, PHP script should be accessible from your web server.

I found it convenient to have `downloads` subfolder accessible from
the web server, presuming that [directory listing][2] is turned on.
YMMV.

Security considerations
-----------------------

I plan to run this only on safe environment, like localhost or home LAN.

I think it is very bad idea to run the app on publically available server.
Think yourself how to restrict access to your installation.

Building Docker image
---------------------

No ready-to-use docker images published, sorry.
You can build image by running such command:

```sh
docker build -t ytdl ./
```

If you want to force rebuilt image (to get latest _youtube-dl_ version),
do this:


```sh
docker build -t ytdl --no-cache ./
```

Install
-------

PHP process (e.g., FPM) must have write permission to file `list_todo.txt`.

Script named `cronjob` must have write permission to files `list_todo.txt`,
`list_done.txt`, `list_errors.txt`, and to subfolder `downloads`.

Those folder and files is not included in this Git repository.
Moreover, they are listed in `.gitignore`.
You have to create them by youself.

```sh
mkdir -m777 downloads

touch list_todo.txt list_done.txt list_errors.txt
chmod 0666 list_todo.txt list_done.txt list_errors.txt
```

NOTE: of course, it would be better to avoid 0666 and 0777 file modes.
This is just a rude example. Think youself on your host security.
Ensure that `./cronjob` and PHP app both can access their files.

Cronjob
-------

The script downloads one video per run, to avoid high traffic or CPU load.

You can edit user's crontab with command `crontab -e`.
Here is example user's crontab line:

```crontab
*/15 * * * * /var/www/vhosts/ytdl.localhost/cronjob
```

Bookmarklet
-----------

There is simple bookmarklet for adding videos to the download queue:

```js
javascript:window.location="http://ytdl.localhost/ui.php?url="+encodeURIComponent(window.location.href);
```

(you need to replace `ytdl.localhost` to your script path).

[1]: https://github.com/ytdl-org/youtube-dl/
[2]: https://httpd.apache.org/docs/2.4/mod/mod_autoindex.html
