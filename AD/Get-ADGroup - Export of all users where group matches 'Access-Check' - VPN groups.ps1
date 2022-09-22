#Status: UNTESTED 

#Module:
#Module Version: 
#Modified date: 2021.06.09
#PIM permissions: N/A
#Command: Get-ADGroup
#Purpose and use case: When we need to target VPN users with comms / changes, this is a method to export everyone. The email address cannot be trusted.
#Note: You will need to delete an existing version of the VPNUsers.csv file

 

$Groups = Get-ADGroup -Filter 'name -like "Access-Check*"'
$Results = $Groups | Foreach-Object {Get-ADGroupMember -Identity $_ | Get-ADUser -property samaccountname,emailaddress | Select-Object -Property samaccountname,emailaddress}
$Results | Export-Csv -Path C:\Temp\VPNUsers.csv
