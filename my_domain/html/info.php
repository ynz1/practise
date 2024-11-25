<!DOCTYPE html>
<html>
<head>
    <title>Информация о сервере</title>
    <meta charset="UTF-8">
</head>
<body>
<?php
echo "<h1>Информация о сервере</h1>";

echo "<h2>Server Details</h2>";
echo "<p><strong>Server Name:</strong> " . $_SERVER['SERVER_NAME'] . "</p>";
echo "<p><strong>Server IP:</strong> " . $_SERVER['SERVER_ADDR'] . "</p>";
echo "<p><strong>Server Software:</strong> " . $_SERVER['SERVER_SOFTWARE'] . "</p>";
echo "<p><strong>Server Protocol:</strong> " . $_SERVER['SERVER_PROTOCOL'] . "</p>";
echo "<p><strong>Document Root:</strong> " . $_SERVER['DOCUMENT_ROOT'] . "</p>";
echo "<p><strong>Request Method:</strong> " . $_SERVER['REQUEST_METHOD'] . "</p>";
echo "<p><strong>Server Port:</strong> " . $_SERVER['SERVER_PORT'] . "</p>";

echo "<h2>Server Time</h2>";
echo "<p><strong>Current Time (Server):</strong> " . date('Y-m-d H:i:s') . "</p>";

echo "<h2>PHP Environment</h2>";
echo "<p><strong>PHP Version:</strong> " . phpversion() . "</p>";
echo "<p><strong>PHP SAPI:</strong> " . php_sapi_name() . "</p>";

phpinfo();
?>
</body>
</html>
