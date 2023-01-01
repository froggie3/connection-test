<?php

$hostname = 'www.city.chiba.jp';
$ip = gethostbyname($hostname);
$seq = 0;

// for logging

function name_logfile(): string
{
    $Now = new DateTime('now', new DateTimeZone('Asia/Tokyo'));
    $datetime = $Now->format('Ymd_Hi'); //20230101_0446
    $logname = sprintf("./logs/%s_pingtester.log", $datetime);
    unset($now);

    return $logname;
}

$logfp = fopen(name_logfile(), 'a+');

for (;;) {

    $log = '';
    $output = [];

    // for timestamp
    $Now = new DateTime('now', new DateTimeZone('Asia/Tokyo'));
    $timestamp = $Now->format(DateTimeInterface::ATOM);

    // time mesurement
    $time_start = microtime(true);
    $fp = fsockopen($ip, 80, $error_code, $error_message, 3.0);
    $time_end = microtime(true);
    $time = 1000 * ($time_end - $time_start);

    if (!$fp) {
        $log = sprintf("%s: fail: seq=%s \n", $timestamp, $seq);
        exec('pwsh ./traceroute.ps1', $output);
        for ($i = 0; $i < count($output); $i++) {
            $log .= $output[$i] . "\n";
        }
        sleep(5);
    } else {
        $log = sprintf("%s: %s (%s) seq=%s time=%.1f ms \n", $timestamp, $hostname, $ip, $seq, $time);
    }

    // show on console
    echo $log;

    // write on log
    if (fwrite($logfp, $log) === false) {
        echo "Cannot write to file ($filename)";
        exit;
    }

    sleep(2);
    $seq++;
    unset($now);
}

fclose($fp);
