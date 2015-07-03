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
