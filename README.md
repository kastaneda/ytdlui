Personal web app to run `youtube-dl` dockerized
==================================================

Sometimes, while watching internet video, I want to make a local copy.
To save it, to not waste traffic and to be able watch it offline.
This app is designed to automate such tasks.

I presume that you already know what [youtube-dl][1] is.

Important point is that I usally do not want to interrupt the video.
Just make a side-note to download it later.
There is non-blocking bookmarklet to enqueue current URL.
Actual downloading is done via slow lazy cronjob, one video per run.


Security considerations
-----------------------

**WARNING.**
This is web app intended for personal use on local web server.
Think yourself how to restrict access to your installation.

If you don't know what it's about, stop now.


How to install it
-----------------

Prerequisites: `make`, Docker, and web server with PHP.

1. Download (or `git clone`) it;
2. Configure your web server (see below);
3. Setup folders and permissions: run `make install` (see below);
4. Build Docker image: run `make build`;
5. Setup cronjob: run `crontab -e`, and add something like this:

```crontab
*/15 * * * * /var/www/vhosts/ytdl.localhost/cronjob
```

### Note about configuring web server

PHP script `ui.php` must be accessible from your web server.

There is no index file. I prefer to use it with [autoindex][2] enabled.
I like to see internals (like `list_errors.txt`),
and to be able browse `downloads/` subfolder.

### Note about permissions

 - PHP process (e.g., FPM) must have write permission to file `list_todo.txt`;
 - Cron job must have write permission to current folder,
   to files `list_todo.txt`, `list_done.txt`, `list_errors.txt`,
   and to subfolder `downloads`;
 - Command `make install` will cast dumbest 0777/0666 chmod to ensure that.

Note: those folder and files is not included in this Git repository.
Moreover, they are listed in `.gitignore`.

Note: of course, it would be better to avoid 0666 and 0777 file modes.
This is just a rude example. Think youself on your host security.
Ensure that `./cronjob` and PHP app both can access their files.


How to use it
-------------

There is bookmarklet to enqueue current video:

```js
javascript:(function(){var el=document.createElement('div');el.innerHTML='<div style="position:fixed;right:25px;top:25px;background:#eea;padding:10px;z-index:9999"><img alt="Adding to list..." src="http://ytdlui.localhost/ui.php?url='+encodeURIComponent(window.location.href)+'&output=image"></div>';el.onclick=function(e){this.parentNode.removeChild(this);};document.body.appendChild(el);})();
```

(you should replace `ytdlui.localhost` to your script path).


[1]: https://github.com/ytdl-org/youtube-dl/
[2]: https://httpd.apache.org/docs/2.4/mod/mod_autoindex.html
