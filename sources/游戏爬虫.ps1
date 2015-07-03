$url = "http://cafebabe.cc/nazo/helloworld.html"
Function Detect-HttpStatusCode ([uri]$Url)
{
    trap [Net.WebException]
    {
        if($_.Exception.Response -eq $nullsudo)
        {
            return 100
        }
        return [int]($_.Exception.Response.StatusCode)
    }
    return (Invoke-WebRequest $Url ).StatusCode
}
$code = Detect-HttpStatusCode -Url $url
$code