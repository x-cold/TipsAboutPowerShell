function New-Shortcut ($Name, $Path, $Icon)
{
    # 创建WScript.Shell的COM组建
    $shell = New-Object -ComObject WScript.Shell
    $desktop = [System.Environment]::GetFolderPath('Desktop')

    $shortcut = $shell.CreateShortcut("$desktop\$Name.lnk")
    $shortcut.TargetPath = "$Path"
    $shortcut.IconLocation = "shell32.dll,$Icon"
    $shortcut.Save()
}
# 设置测试路径
$path = "\\IDEA\LOL"
# 测试网络路径是否存在
$flag = Test-Path $path
if ($flag)
{
    New-Shortcut -Name test -Path $path -Icon 4
}
else
{
    New-Shortcut -Name test11 -Path C:\bfs -Icon 4
}