#Status: UNTESTED

#Module: Connect-MsolService
#Module Version: 1.1
#Modified date: 2021/04/28
#Permissions: Office Admin
#Command: Set-MsolUser -PasswordNeverExpires
#Purpose and use case: Set specific AAD user password to never expire
#Template: Not relevant


Set-MsolUser -UserPrincipalName fullemailaddress@yourdomain.com -PasswordNeverExpires $true
