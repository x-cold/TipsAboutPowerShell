# 等待堵塞
function WaitForLoad ($ie)
{
    while($ie.Busy)
    {
        sleep -Milliseconds 50
    }
}

#获取html元素
function Get-HtmlElement ($Id,$Name,$Class,$Tag)
{
    if($Id)
    {
        return $ie.Document.getElementById($id)
    }
    elseif($Name)
    {
        return $ie.Document.getElementsByName($Name)
    }
    elseif($Class)
    {
        $ie.Document.all |　where {$_.className -contains $Class}
    }
    elseif($Tag)
    {
        $ie.Document.getElementsByTagName($Tag)
    }
}

# 获取信息
function getInfo($url)
{
    $ie.Navigate($url)
    WaitForLoad($ie)
    $tbody = Get-HtmlElement -Tag tbody
    $tbody[1].innerText >> D:\info.txt
    "----------" >> D:\info.txt
}

# 创建浏览器对象
$ie = New-Object -ComObject "InternetExplorer.Application"
$url = 'http://acm.scau.edu.cn:8000/uoj/register/displayActivity.html?id=29&page=1'

$ie.Navigate($url)
WaitForLoad($ie)

# 获得页面数量
$count = Get-HtmlElement -Class pagelinks
$matches = [regex]::matches($count.innerText,"\b\d+\b")
$page = $matches[$matches.count -1].Value;

# 处理url
for ($i = 1; $i -le 11; $i++)
{
    $url = "http://acm.scau.edu.cn:8000/uoj/register/displayActivity.html?id=29&page=" + $i
    Write-Host $(Get-Date)  "正在处理"  $url
    getInfo($url)
}