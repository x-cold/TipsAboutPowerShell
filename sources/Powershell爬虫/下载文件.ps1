$web = New-Object System.Net.WebClient
$web.Encoding = [System.Text.Encoding]::UTF8
$url = "http://t11.baidu.com/it/u=2096644525,2872056305&fm=58"
$dest = "D:\tst.png"
Write-Host $url 下载中...请稍后 -ForegroundColor Cyan
$web.DownloadFile($url, $dest)
$result=Test-Path $dest
#对 $result 结果进行判断是否下成功下载
if($result -eq $True)
{
    Write-Host $url 下载成功! -ForegroundColor Green
}
else
{
    Write-Host $url 下载失败! -ForegroundColor Red
}