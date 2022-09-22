Status: TESTED

#Module: Connect-AzureAD
#Module Version: 1.1
#Modified date: 2022/05/17
#Permissions: Azure Admin
#Command: Get-AzureADGroup, Get-AzureADGroupMember
#Purpose: Export members of a defined group with given attributes.
#Template: Single column CSV with header 'ObjectID' and the ObjectID of the users listed below it
#Notes: 
#Example of group name: 'Windows Store - IT Applications - IT Staff'
 
# define variable for aad  group
$AADGroup = "GROUP NAME"
 
# get Azure AD Group members and export to CSV
Get-AzureADGroup -SearchString $AADGroup | Get-AzureADGroupMember | Select DisplayName, UserPrincipalName, GivenName, Surname, JobTitle, Department, physicalDeliveryOfficeName, Mail, @{n='Manager';e={(Get-AzureADUserManager -ObjectId $_.ObjectId).displayname}}  | Export-Csv -path "c:\temp\$AADGroup-members-$((Get-Date).ToString('dd-MM-yyyy')).csv" 
