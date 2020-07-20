
##[array]::IndexOf($array, ($array | sort-object -Descending | Select -last 1)) ## hmm use this somehow

function GetRandomDatabaseName($Contentdatabases){
##

# Need to build an array first based on the command to also include the "_restored" named db's as well

$appendedtext = "","_restored"  #the content db either has this value or it doesn't normal numbering
<#
 $dbnames =@() #if I declare this here I can remove it from both below
        $dbnames+=("WSS_Content_edms_" + "$commandToSearch" + "_00$i")
        $dbnames+=("WSS_Content_edms_" + "$commandToSearch" + "_00$i" + "$appendedtext")
        $dbnames+=("WSS_Content_edms_" + "$altDBName" + "_00$i")
        $dbnames+=("WSS_Content_edms_" + "$altDBName" + "_00$i" + "$appendedtext")


$excludedb=@() #these will be db that whilst not having maximum db in them have the issue of being to big data wise
	$excludedb+=("WSS_Content_edms_shape_004")
#>


$max = 0;
foreach($i in (1..$Contentdatabases ))
{





    $dbnames =@() #would I be able to enter the following array just once  beneath the $appended text above presently commented out
        $dbnames+=("WSS_Content_edms_" + "$commandToSearch" + "_00$i")
        $dbnames+=("WSS_Content_edms_" + "$commandToSearch" + "_00$i" + "$appendedtext")
        $dbnames+=("WSS_Content_edms_" + "$altDBName" + "_00$i")
        $dbnames+=("WSS_Content_edms_" + "$altDBName" + "_00$i" + "$appendedtext")

    foreach($dbname in $dbnames)
    {
    
            if($altDBName -ne $null)
            {
		#skipping a db that is to big datawise
		if($excludedb -contains $dbname)
       		{   
    
        	Write-Host "Skipping db: $($dbname) no action required" -ForegroundColor Yellow

        	continue}





                #$dbname = "WSS_Content_edms_" + $altDBName + "_00$i" + "$appendedtext"    # how do I say it can be with or without $appendtext to get the number of dbs for the command
                $dbname = "WSS_Content_edms_" + $altDBName + "_00$i" # how do I say it can also be with $appendtext
            }
        $db = Get-SPContentDatabase $dbname

            if($db -eq $null) {
            write-host "Error retrieving content database $dbname" -ForegroundColor red
            exit
            }

        $dif = $db.MaximumSiteCount - $db.CurrentSiteCount
            if($dif -gt $max){
                $max = $dif
            }
    } 
}
$dbs = @()
    foreach($i in (1..$Contentdatabases ))
    {
    $dbnames =@()
        $dbnames+=("WSS_Content_edms_" + "$commandToSearch" + "_00$i")
        $dbnames+=("WSS_Content_edms_" + "$commandToSearch" + "_00$i" + "$appendedtext")
        $dbnames+=("WSS_Content_edms_" + "$altDBName" + "_00$i")
        $dbnames+=("WSS_Content_edms_" + "$altDBName" + "_00$i" + "$appendedtext")

    foreach($dbname in $dbnames)
    {
    
            if($altDBName -ne $null)
            {
		#skipping a db that is to big datawise
		if($excludedb -contains $dbname)
       		{   
    
        	Write-Host "Skipping db: $($dbname) no action required" -ForegroundColor Yellow

        	continue}


                $dbname = "WSS_Content_edms_" + $altDBName + "_00$i" # how do I say it can also be with $appendtext
            }
        $db = Get-SPContentDatabase $dbname

            if($db -eq $null) {
            write-host "Error retrieving content database $dbname" -ForegroundColor red
            exit
            }

        $dif = $db.MaximumSiteCount - $db.CurrentSiteCount
            if($dif -gt $max){
                $dbs += $dbname
            }
    }
        $random = 0;
        if( $dbs.Length -ne 1){
            $random = Get-Random -Minimum 1 -Maximum $dbs.Length
        }
        return $dbs[$random]
}

}

##
<#
    $max = 0;
    foreach($i in (1..$Contentdatabases )){
       


        $dbname = "WSS_Content_edms_" + "$commandToSearch" + "_00$i"
        
        if($altDBName -ne $null)
        {
            $dbname = "WSS_Content_edms_" + $altDBName + "_00$i"
        }
        #$db = Get-SPContentDatabase "WSS_Content_edms_act_001_restored"
       $db = Get-SPContentDatabase $dbname
        if($db -eq $null) {
            write-host "Error retrieving content database $dbname" -ForegroundColor red
            exit
        }

        $dif = $db.MaximumSiteCount - $db.CurrentSiteCount
        if($dif -gt $max){
            $max = $dif
        }
    }
  
    $dbs = @()
    foreach($i in (1..$Contentdatabases )){
        $dbname = "WSS_Content_edms_"+"$commandToSearch"+"_00$i"
        if($altDBName -ne $null)
        {
            $dbname = "WSS_Content_edms_" + $altDBName + "_00$i"
        }
        $db = Get-SPContentDatabase $dbname
        if($db -eq $null) {
            write-host "Error retrieving content database $dbname" -ForegroundColor red
            exit
        }
        $dif = $db.MaximumSiteCount - $db.CurrentSiteCount
        if($dif -eq $max){
            $dbs += $dbname
        }
    }

    $random = 0;
    if( $dbs.Length -ne 1){
        $random = Get-Random -Minimum 1 -Maximum $dbs.Length
    }
    return $dbs[$random]
} 
 #>