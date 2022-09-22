#Status: TESTED

#Module: ActiveDirectory
#Module Version: Unknown
#Modified date: 2021/01/07
#Permissions: Access to the AD server
#Command: Get-ADUser
#Purpose: To export all users within AD
#Template: Not required
#Example Get-ADUser -Filter * -Properties * | export-csv "C:\Users\da.sparry\AD all users.csv"
 
 
Get-ADUser -Filter * -Properties * | export-csv c:\Users\USERNAME\desktop\AllADusers.csv

