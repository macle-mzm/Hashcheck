#生成或校验文件的hashsum的powershell程序 V2
#生成时：powershell .\hashsum.ps1 file MD5|SHA1|SHA256|SHA384|SHA512
#校验时：powershell .\hashsum.ps1 -C hashsum.asc MD5|SHA1|SHA256|SHA384|SHA512
#对于第一次使用powershell的用户，需要先使用管理员权限打开powershell,并运行：
#    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned
#才能打开本地运行powershell脚本权限
#mzm 2019.10.14.

$ALG="SHA1"

if($args[0] -eq "-c"){

    switch ($args.length) {
        2 {Write-Output "Check SHA1"}
        3 { $ALG=$args[2]}
        default {
            Write-Output "hashsums -C hashsum.asc MD5|SHA1|SHA256|SHA384|SHA512...."
            EXIT
        }
    }

    $LINE=type $args[1]
    $TMP=$LINE.Split(' ')
    $HASH=$TMP[0]
    $FILE=$LINE.Substring($LINE.IndexOf(' ')).trim()
    $RESULT=Get-FileHash $FILE -Algorithm $ALG
    $RESULT.Hash -eq $HASH

}
else{

    switch ($args.length) {
        1 {Write-Output "Algorithm SHA1"}
        2 { $ALG=$args[1]}
        default {Write-Output "hashcheck hashsum.asc MD5|SHA1|SHA256|SHA384|SHA512...."
            EXIT
        }
    }
    $FS=$args[0].Split("\")
    $FILE=$FS[$FS.Length-1]
    $RESULT=Get-FileHash $args[0] -Algorithm $ALG
    $RESULT.Hash,$FILE -join ' '

}
