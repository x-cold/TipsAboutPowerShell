#
# 打开IE窗口
#
function New-IEWindow
{
   param(
   [string]$Url,
   [switch]$Visible,
   [switch]$FullScreen
   )
   $Global:IEHost = new-object -com "InternetExplorer.Application"
   $Global:IEHost.Navigate($Url)
  
   #设置IE可见性和全屏
   $Global:IEhost.Visible= $Visible
   $Global:IEHost.FullScreen= $FullScreen
     
}
 
#
#等待IE加载完毕
#
function Wait-IEReady([int]$TimeoutSeconds=10)
{
    $milliseconds=0
    $maxMilliseconds = $TimeoutSeconds * 1000
    while($Global:IEHost.Busy)
    {
        
      if($milliseconds -gt $maxMilliseconds)
      {
        throw 'Wait ie ready timeout.'
      }
      sleep -Milliseconds 100
      $milliseconds+=100
        
    }
}
 
#
# 根据ID，Class，Name，Tag获取HTML元素
#
function Get-HtmlElement ($Id,$Name,$Class,$Tag)
{
  if($Id)
  {
    return $IEHost.Document.getElementById($id)
  }
  elseif($Name)
  {
    return $IEHost.Document.getElementsByName($Name)
  }
  elseif($Class)
  {
    $IEHost.Document.all |　where {$_.className -contains $Class}
  }
  elseif($Tag)
  {
    $IEHost.Document.getElementsByTagName($Tag)
  }
    
}
 
#
#关闭IE窗口
#
function Close-IEWindow
{
    $Global:IEHost.quit()
    Remove-Variable IEHost -Force
}
 
#
#设置IE的地址
#
function Navigate-IE($Url)
{
 Set-IE -URL $Url
}
  
#
# 设置IE的地址，或者动作：前进，倒退，刷新
#
function Set-IE
{
 param(
 [ValidateSet('GoBack', 'GoForward','Refresh')]
 [string]$Action,
 [uri]$URL
 )
  
 # 动作
 switch($Action)
 {
  ('GoBack'){ $Global:IEHost.GoBack() }
  ('GoForward'){  $Global:IEHost.GoForward() }
  ('Refresh'){ $Global:IEHost.Refresh() }
 }
  
 # 设置IE地址
 if( $URL) {
 $Global:IEHost.Navigate($URL) }
}
#
# 在IE窗口中执行脚本
#
function Invoke-IEScript($Code,$Language='Javascript')
{
 if( -not [string]::IsNullOrWhiteSpace($Code))
 {
  $Global:IEHost.Document.parentWindow.execScript($Code,$Language)
 }
}

function Start-Server ()
{
    $textPath = 'E:\Project\powershell\登入正方\config.ini'
    $urls = Get-Content $textPath | where { !([string]::IsNullOrWhiteSpace($_))}
    $urls = $urls -split '`n'
    $map = "http://" + $urls[0] + "//default_ysdx.aspx"
    #New-IEWindow -Url $map -Visible true
    New-IEWindow -Url $map -Visible true
    Invoke-IEScript -Code "alert('hhhh')"
    # Invoke-IEScript -Code "document.getElementById('TextBox1').value = '201330320123';"
    # Invoke-IEScript -Code "document.getElementById('TextBox2').value = 'wwx1234567890';"
    # Invoke-IEScript -Code "document.getElementById('Button1').click();"
}