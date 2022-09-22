#Status: TESTED

#Module: AD
#Module Version: 
#Modified date: 2022/05/09
#PIM permissions: None
#Command: Get-ADGroupMember
#Purpose and use case: To get a list of all members of a given AD group for analysis (name and SAM)
#Template: None


Get-ADGroupMember -identity "GroupName" | select-object Name,samaccountname | Export-csv -path c:\temp\GroupName.csv -Notypeinformation
