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

$message = $download_status = null;

if (isset($_GET['url'])) {
    $url = $_GET['url'];
    if ($download_status = add_to_download_list($url)) {
        $message = sprintf(
            'URL <a href="%s">%s</a> is scheduled for downloading',
            $url,
            htmlspecialchars($url)
        );
    }
}

header('Cache-Control: no-store, no-cache, must-revalidate, max-age=0');
if (isset($_GET['output']) && ($_GET['output'] == 'image')) {
    $file = $download_status ? 'status_good.png' : 'status_bad.png';
    header('Content-type: image/png');
    echo file_get_contents(__DIR__ . '/' . $file);
} else {
    render_ui($message);
}
