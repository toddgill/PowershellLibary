#Status: TESTED

#Module: Connect-ExchangeOnline
#Module Version: 
#Modified date: 01/08/2022
#Permissions: Exchange
#Command: Get-MailboxFolderStatistics , Get-Mailbox 
#Purpose and use case: To extract users recoverable items mailbox size


#Get User mailbox size from a csv of specific users (1 column with header Identity with list of email addresses below)
$Users = Import-csv C:\temp\MailboxStatsTest.csv
$Users | foreach {Get-MailboxFolderStatistics -Identity $_.Identity -FolderScope RecoverableItems -ResultSize 1} | Select Identity,FolderAndSubfolderSize | Export-Csv C:\Temp\RecoverableItems.csv -NoTypeInformation

Example of csv below
Identity
--------
todd.gill@statsperofrm.com
sean.parry@statsperform.com


#Get all users mailbox size (Takes ~4 hours)
$All = Get-Mailbox -ResultSize Unlimited
$All | foreach {Get-MailboxFolderStatistics -Identity $_.Identity -FolderScope RecoverableItems -ResultSize 1} | Select Identity,FolderAndSubfolderSize | Export-Csv C:\Temp\RecoverableItems.csv -NoTypeInformation
