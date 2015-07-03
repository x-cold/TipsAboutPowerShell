# 预设下载路径
$serPath = "http://www.zhinengshe.com/works/"
$filePath = "D:\Download\"
$textPath = "E:\Project\powershell\Powershell爬虫\智能社\data.txt"

# 获取编号信息
$info = Get-Content $textPath | where { !([string]::IsNullOrWhiteSpace($_))}
$info = $info -split '`n'

# 下载文件
# 实例：http://www.zhinengshe.com/works/3533/3533.zip
$web = New-Object System.Net.WebClient
$web.Encoding = [System.Text.Encoding]::UTF8
foreach($num in $info)
{
    $url = $serPath + $num + "/" + $num + ".zip"
    $dest = $filePath + $num + ".zip"
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
}
Write-Host 下载完毕，正在退出程序 -ForegroundColor Red