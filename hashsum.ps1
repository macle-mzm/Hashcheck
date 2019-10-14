#生成文件的hashsum的powershell程序
#运行时需要：powershell .\hashsum.ps1 file MD5|SHA1|SHA256|SHA384|SHA512
#对于第一次使用powershell的用户，需要先使用管理员权限打开powershell,并运行：
#    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
#才能打开本地运行powershell脚本权限
#mzm 2019.10.14.

$ALG="SHA1"
switch ($args.length) {
    1 {Write-Output "Check SHA1"}
    2 { $ALG=$args[1]}
    default {Write-Output "hashcheck hashsum.asc MD5|SHA1|SHA256|SHA384|SHA512...."
        EXIT}
}
$FS=$args[0].Split("\")
$FILE=$FS[$FS.Length-1]
$RESULT=Get-FileHash $args[0] -Algorithm $ALG
$RESULT.Hash,$FILE -join ' '
