#方便校验hash的powershell程序
#运行时需要：powershell .\hashcheck.ps1 hashsum.asc MD5|SHA1|SHA256|SHA384|SHA512
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

$LINE=type $args[0]
$TMP=$LINE.Split(' ')
$HASH=$TMP[0]
$FILE=$LINE.Substring($LINE.IndexOf(' ')).trim()
$RESULT=Get-FileHash $FILE -Algorithm $ALG
$RESULT.Hash -eq $HASH
