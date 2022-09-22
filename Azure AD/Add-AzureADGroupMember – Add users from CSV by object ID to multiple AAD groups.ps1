Status: TESTED

#Module: Connect-AzureAD
#Module Version: 1.1
#Modified date: 2021/01/04
#Permissions: Azure Admin
#Command: Add-AzureADGroupMember
#Purpose: Add listed users from a file to given AAD security groups. Does not affect existing Members.
#Template: Single column CSV with header 'ObjectID' and the ObjectID of the users listed below it
#Notes: Future builds - there is a way to have the UPN in the CSV and the PowerShell does a look-up for each row. You can get the user ObjectID (called 'ID' from the Azure all users export in Azure AD)
#Example of group name: 'SSO - ServiceNow - Users'
 
$groupIDs = 'Group Name 1', 'Group Name 2' | Foreach-Object {Get-AzureADGroup -SearchString $_} | Select -ExpandProperty ObjectId; Import-Csv -path "C:\Temp\User-ObjectID-List.csv" | Foreach-Object {foreach($groupID in $groupIDs) {Add-AzureADGroupMember -ObjectId $groupID -RefObjectId $_.ObjectId}}

