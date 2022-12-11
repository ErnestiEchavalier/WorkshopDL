foreach($folder in Get-ChildItem -Path . -Name)
{ 
	$output = (curl https://steamcommunity.com/sharedfiles/filedetails/?id=$folder).Content.Split([Environment]::NewLine) ; 
	$title =  ($output | Select-String \<title\>).ToString().Trim().Replace("<title>","").Replace("</title>","").Replace("Steam Workshop::","") ; 
	if ( $title -ne "Steam Community :: Error" ) 
	{ 

		$date = ($output | Select-String '<div class="detailsStatRight">')[2].ToString().Trim().Replace('<div class="detailsStatRight">',"").Replace("</div>","") ; 
		$parseddate = try { ([DateTime] $date.Replace('@',(Get-Date).year)).ToString('yyyy-MM-dd-HHmm') } catch { ([DateTime] $date.Replace('@','')).ToString('yyyy-MM-dd-HHmm') } ; 
		Rename-Item "$folder" "$title $parseddate" 
	} ; 
	sleep 2 
} ; 
"Folders updated"
