<#
#   ping-tester (implemented with PowerShell)
#   author: iigau
#>

$var = @{
    host = 'www.city.chiba.jp'
}

$cmdlet = @{
    traceroute = 'Test-NetConnection -traceroute'
    ls         = 'Get-ChildItem .'
}

# ホスト名から IP アドレスを逆引き
$ip = [string](Resolve-DnsName $var['host'] | ForEach-Object -Process { $_.IPAddress })

# コマンドレットを生成
$timestamp = $("{0:yyyy-MM-dd\THH:mm:ssK}" -f (Get-Date)) # 評価演算子 + $( ) 部分式演算子
$timestamp_message = (@(<#':', #>'traceroute to', $var['host'], "($($ip))") -join ' ') -replace "  ", ""

$traceroute = Invoke-Expression (@($cmdlet['traceroute'], $var['host']) -join ' ') | Out-String -Stream | ? { $_ -ne "" }

# 結合した文字列を式として評価し、出力された出力の結果を配列として取得
Write-Output (@(<#$timestamp, #>$timestamp_message) -join '')
#| Tee-Object -FilePath '.\logging.log' -Append

Write-Output ($traceroute)
#| Tee-Object -FilePath '.\logging.log' -Append