function FindIPtype {
	param($ipAddress)
	$ip = [System.Net.IPAddress]::Parse($ipAddress)
	if($ip.AddressFamily -eq 'InterNetworkV6') {
		Write-Output "$ipAddress is not a valid IPv4 address"
		return
	}
	
	$octects = $ipAddress -split '\.'
	
	if(($octects[0] -eq 10) -or
	   ($octects[0] -eq 172 -and $octects[1] -ge 16 -and $octects[1] -le 31) -or
	   ($octects[0] -eq 192 -and $octects[1] -eq 168)) {
	    	Write-Output "$ipAddress	private address"
		} 
	else {
			Write-Output "$ipAddress	public address"
	}
}

$filePath = "C:\Users\navee\Documents\TheCloudUniverse\PS scripts\IpsList.txt"
$unique = Get-Content $filePath | Get-Unique
Set-Content -Path $filePath -Value $unique

#Get the contnets of the filePath
$content = Get-Content -Path 'C:\Users\navee\Documents\TheCloudUniverse\PS scripts\IpsList.txt'

#loop
foreach ($line in $content) {
FindIPtype $line
}
