## powershell exercise
 

get-hotfix 


##  manipulate the file and folder 

new-item   -Path 'C:\test' -Itemtype  folder|file


# copy item will copy the folder recursively 
Copy-Item | Move item 'C:\path1' 'C:\path2'
# copy item will copy the file  recursively  with the wild card   such as path1\*.txt
Copy-Item  'C:\path1\file1.txt' 'C:\path2\file2.txt'
# remove  item includes   folders  files  alias   registry keys  vars and functions 

# till now we learned all crud operations
# test path used to find the file is there or not   Return Ture or False

New-Item|Remove-Item|Remove-Item|Move-Item| Copy-Item | Get-Content | test-path

## Date related operation 
# get-date |set-date 

## use powershell  connect sql server  and run store procedure



$SqlConnection = New-Object System.Data.SqlClient.SqlConnection

$SqlConnection.ConnectionString="Server=.Password=Ms02481299350;database=#test;Integrated Security=True"
$SqlCmd= New-Object System.Data.SqlClient.SqlCommand
$SqlCmd.CommandText='check_status_aggregated'
$SqlCmd.Connection=$SqlConnection
$SqlAdapter= New-Object System.Data.SqlClient.SqlDataAdapter
$SqlAdapter.SelectCommand= $SqlCmd
$Dataset= New-Object System.Data.DataSet
$SqlAdapter.Fill($Dataset)
$SqlConnection.Close()
$Dataset.Tables[0]




$connectionStr = "Data Source= 127.0.0.1;Initial Catalog=.;User ID=v-zhenya;pwd=Ms02481299350"

function New-SqlConnection([string]$connectionStr)
{
    $SqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $SqlConnection.ConnectionString = $connectionStr
    try{
        $SqlConnection.Open()
        Write-Host 'Connected to sql server.'
        return $SqlConnection #返回数据库连接的信息
    }
    catch [exception]{
        Write-Warning ('Connect to database failed with error message:{0}' -f,$_)
        $SqlConnection.Dispose()
        return $null
    }
}
 
function Excute-SqlCommandNonQuery
{
    #声明需要两个变量
    #$SqlConnection连接数据库返回的信息
    #$Command sql语句
    param 
    (
    [System.Data.SqlClient.SqlConnection]$SqlConnection,
    [string]$Command
    )
    $SqlConnection = New-SqlConnection($connectionStr)#调用数据库连接的函数
    $Command = "select * from #test"
    $cmd = $SqlConnection.CreateCommand()
    try
    {
        $cmd.CommandText = $Command
        $cmd.ExecuteNonQuery() | Out-Null
        return $true
    }
    catch [Exception]{
        Write-Warning('Execute Sql command failed with error message:{0}' -f,$_)
        return $false
    }
    finally{
        $SqlConnection.Close()
    }
}
 






