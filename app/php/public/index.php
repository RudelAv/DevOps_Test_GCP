<?php

declare(strict_types=1);

$appName = 'GCP PHP Infrastructure: Deploying a PHP Application on Google Cloud Platform';
$phpVersion = PHP_VERSION;

$dbHost = getenv('DB_HOST');
$dbName = getenv('DB_DATABASE');
$dbUser = getenv('DB_USERNAME');
$dbPassword = getenv('DB_PASSWORD');

$dbConnected = false;
$dbError = null;

if (!$dbHost || !$dbName || !$dbUser || !$dbPassword) {
    $dbError = 'Database configuration is incomplete.';
} else {
    try {
        // Connecction to MySQL database using PDO
        $dsn = sprintf(
            'mysql:unix_socket=%s;dbname=%s;charset=utf8mb4',
            $dbHost,
            $dbName
        );

        $pdo = new PDO($dsn, $dbUser, $dbPassword, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        ]);

        // check the connection
        $pdo->query('SELECT 1');

        $dbConnected = true;

    } catch (PDOException $e) {
        
        error_log('Database connection failed: ' . $e->getMessage());

        $dbError = 'Unable to connect to the database.';
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title><?= htmlspecialchars($appName, ENT_QUOTES, 'UTF-8') ?></title>

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
            font-weight: bold;
        }

        .success {
            color: #16834a;
        }

        .error {
            color: #dc2626;
        }
    </style>
</head>

<body>
    <main>
        <h1><?= htmlspecialchars($appName, ENT_QUOTES, 'UTF-8') ?></h1>

        <p class="success">Application is running</p>

        <p>Web Server : Nginx</p>
        <p>PHP Engine : PHP-FPM</p>
        <p>PHP Version : <?= htmlspecialchars($phpVersion, ENT_QUOTES, 'UTF-8') ?></p>
        <p>Environment : Cloud Run / Docker</p>

        <hr>

        <h2>Database Connection</h2>

        <?php if ($dbConnected): ?>
            <p class="status success">
                Database connection successful!
            </p>
            <p>Database : <?= htmlspecialchars($dbName, ENT_QUOTES, 'UTF-8') ?></p>
            <p>Connection : Cloud SQL / MySQL</p>
        <?php else: ?>
            <p class="status error">
                Database connection failed.
            </p>
            <p><?= htmlspecialchars($dbError ?? 'Unknown error', ENT_QUOTES, 'UTF-8') ?></p>
        <?php endif; ?>

    </main>
</body>
</html>
