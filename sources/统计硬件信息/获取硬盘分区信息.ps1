# DriveType = 3 为物理硬盘上的分区
$drives = Get-WmiObject -Class Win32_LogicalDisk -Filter "DriveType=3" -Property *
Foreach($drive in $drives)
{
    $drive.FreeSpace = ($drive.FreeSpace/1024/1024/1024);
    $drive.size = ($drive.size/1024/1024/1024);
}
$drives | Out-GridView