#Status: TESTED

#Module: ActiveDirectory
#Module Version: Unknown
#Modified date: 2022/06/2022
#Permissions: Access to the AD server
#Command: Get-ADUser
#Purpose: To export all users within AD to find out their lastlogon date
#Attributes Used: UserPrincipalName, samaccountname, enabled, lastLogon, lastLogonTimeStamp, Modified
#Note1: Export includes all 3 times but its recommended to use the LastLogonTimeStamp as the most accurate last AD time
#Note2: If you want to get more fields just put attribute name after modified with a comma e.g. , ObjectClass

Get-ADUser -Filter * -Properties * | Select UserPrincipalName, samaccountname, enabled, @{Name="lastLogon";Expression={[datetime]::FromFileTime($_.'lastLogon')}}, @{Name="lastLogonTimeStamp";Expression={[datetime]::FromFileTime($_.'lastLogonTimeStamp')}}, modified | Export-Csv "C:\temp\ADUsersLastLogon.csv"
