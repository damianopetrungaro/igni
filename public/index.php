<?php
declare(strict_types=1);

use Swoole\Http\Request;
use Swoole\Http\Server;
use Swoole\Http\Response;

$server = new Server('0.0.0.0', 8080);

$server->on('start', function () {
    echo 'Swoole http server is started at http://127.0.0.1:8080' . PHP_EOL;
});

$server->on('Request', function (Request $request, Response $response) {
    echo var_export($request->server, true);
    $response->header('Content-Type', 'application/json');
    $response->end('{"api": "Here we are"}');
});

$server->start();