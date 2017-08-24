# Load posh-git example profile
. 'C:\Users\lxstart\Documents\WindowsPowerShell\Modules\posh-git\profile.example.ps1'

pushd e:\github

set-alias g git

function nrs {
   $a = $args
   if ($args -eq "."){ $a = $pwd }
   npm start
}

function nrd {
   $a = $args
   if ($args -eq "."){ $a = $pwd }
   npm run dev
}

function glog { 
   $a = $args
   if ($args -eq "."){ $a = $pwd }
   git log --pretty=format:"[%h] %ad %n[%cn@%ce] %s %n"
}

set-alias reset "$profile"

Write-Host '$env:username: Reloaded Profile'