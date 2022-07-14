<?php

/*
 * @Author: Cloudflying
 * @Date: 2022-07-13 21:10:15
 * @LastEditTime: 2022-07-13 22:17:39
 * @LastEditors: Cloudflying
 * @Description:
 * @FilePath: /dockenv/scripts/env.php
 */

print_r(get_loaded_extensions());

$host = '172.16.3.4';
$memcache_port = 11211;
$mem_sock = $host . ':' . $memcache_port;

if(extension_loaded('memcache')){
    $mem = memcache_connect('172.16.3.4', 11211);
    if ($mem) {
        $mem_ver = $mem->getVersion();
        echo "Memcache $mem_ver connetcted" . PHP_EOL;
    }
}

if(extension_loaded('memcached')){
    $m = new Memcached();
    if ($m->addServer('172.16.3.4', 11211)) {
        $memd_ver = $m->getVersion()[$mem_sock];
        echo "Memcached $memd_ver connetcted " . PHP_EOL;
    }
}

if(extension_loaded('Redis')){
    $redis = new Redis();
    if ($redis->connect('172.16.3.4', 6379)) {
        $redis->auth('dockenv');
        $redis_info = $redis->info();
        $redis_version = $redis_info['redis_version'];
        echo "Redis $redis_version connetcted " . PHP_EOL;
    }
}
