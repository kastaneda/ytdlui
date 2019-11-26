<?php

function add_to_download_list(string $url): bool
{
    return file_put_contents('list_todo.txt', $url . PHP_EOL, FILE_APPEND);
}

function render_ui(?string $message = null)
{ ?><!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Local video cache</title>
  </head>
  <body>
<?php if ($message): ?>
    <p><?php echo $message; ?></p>
<?php endif; ?>
    <form action="">
      <p>
        <label>Video URL: <input type="text" name="url" /></label>
        <input type="submit" value="Download" />
      </p>
    </form>
  </body>
</html><?php
}

if (isset($_GET['url'])) {
    $url = $_GET['url'];
    if (add_to_download_list($url)) {
        $message = sprintf(
            'URL <a href="%s">%s</a> is scheduled for downloading',
            $url,
            htmlspecialchars($url)
        );
    } else {
        $message = 'Something went wrong';
    }
    render_ui($message);
} else {
    render_ui();
}

