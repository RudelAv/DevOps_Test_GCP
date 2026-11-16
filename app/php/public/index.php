<?php

declare(strict_types= 1);

$appName = 'GCP PHP Infrasctructure: 
Deploying a PHP Application on Google Cloud Platform';
$phpVersion = PHP_VERSION;

?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><?= htmlspecialchars($appName) ?></title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f4f6f9;
            color: #202938;
            display: grid;
            place-items: center;
            min-height: 100vh;
            margin: 0;
        }
        main {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 4px 20px rgba(0,0,0,.08);
            max-width: 600px;
        }
        .status {
            color: #16834a;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <main>
        <h1><?= htmlspecialchars($appName) ?></h1>
        <p class="status">Application is running</p>
        <p>Web Server : Nginx</p>
        <p>PHP Engine : PHP-FPM</p>
        <p>PHP Version : <?= htmlspecialchars($phpVersion) ?></p>
        <p>Environment : Cloud Run / Docker</p>
    </main>
</body>
</html>