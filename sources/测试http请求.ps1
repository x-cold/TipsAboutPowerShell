$url = "http://202.116.163.33"
# 追踪执行命令耗时
$timeTaken = Measure-Command -Expression {
  # 保留请求信息，可用于网络爬虫的实现
  $site = Invoke-WebRequest -Uri $url
  ($site) >> D:\text.txt
}

# 获取毫秒数
$milliseconds = $timeTaken.TotalMilliseconds
$milliseconds = [Math]::Round($milliseconds, 1)

Write-Host "It took $milliseconds ms!"