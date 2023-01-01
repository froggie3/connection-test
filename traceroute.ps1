Param( [string]$arg_hostname, [string]$arg_timestamp )

$var = @{ host = 'www.city.chiba.jp' }

$cmdlet = @{ traceroute = 'Test-NetConnection -traceroute' }

# if an argument is set, use them and set new value 
if (!$arg_hostname -eq '') { $var['host'] = $arg_hostname }

# ホスト名から IP アドレスを逆引き
$ip = [string](Resolve-DnsName $var['host'] | ForEach-Object -Process { $_.IPAddress })

# コマンドレットを生成
$traceroute = Invoke-Expression (@($cmdlet['traceroute'], $var['host']) -join ' ') | Out-String -Stream | Where-Object { $_ -ne "" }

if (!$arg_timestamp -eq 'timestamp' ) {
    # 結合した文字列を式として評価し、出力された出力の結果を配列として取得
    $timestamp_message = (@('traceroute to', $var['host'], "($($ip))") -join ' ') -replace "  ", ""
    Write-Output $timestamp_message
}
else {
    $timestamp = $("{0:yyyy-MM-dd\THH:mm:ssK}" -f (Get-Date)) # 評価演算子 + $( ) 部分式演算子
    $timestamp_message = (@(':', 'traceroute to', $var['host'], "($($ip))") -join ' ') -replace "  ", "" 
    Write-Output (@($timestamp, $timestamp_message) -join '')
}

Write-Output ($traceroute)
