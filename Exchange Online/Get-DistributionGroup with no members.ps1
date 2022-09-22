#Status: TESTED

#Module: Connect-ExchangeOnline
#Module Version: 
#Modified date: 2022/05/16
#Permissions: 
#Command: Get-DistributionGroup
#Purpose and use case: Provides an export of Dl's, to the users C drive, of those who have 0 members
#Template: Not relevant
#Note: 

Get-DistributionGroup -ResultSize Unlimited | ? { (Get-DistributionGroupMember $_.PrimarySMTPAddress | Measure-Object).Count -eq 0 } | select DisplayName,PrimarySMTPAddress | Export-CSV C:\temp\DLsWithNoMembers.csv
