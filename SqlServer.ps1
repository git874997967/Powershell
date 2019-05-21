#数据库连接的字符串
$connectionStr = "Data Source= 127.0.0.1;Initial Catalog= .;User ID=v-zhenya;pwd=Ms02481299350"

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
 