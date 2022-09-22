#Status: 

#Module: Connect-AzureAD#Module Version: 1.1#Modified date: 2022/07/01#Permissions: Azure Reader#Command: Get-AzureADUserMembership, Get-AzureADUser#Purpose and use case: Exporting a list of all groups that all guest users are in, could edited to get all users by removing -Filter "UserType eq 'Guest'" from row 11, also includes a write progress so you can see how many records it has processed as it can take a while.

Connect-AzureAD

$Result=""   
$Results=@()  
$GuestCount=0
$PrintedGuests=0

#Output file declaration 
$ExportCSV="C:\temp\UsersWithGroups.csv"
Write-Host `nExporting report... 
#Getting guest users
Get-AzureADUser -All $true -Filter "UserType eq 'Guest'" | foreach {
 $DisplayName=$_.DisplayName
 $Upn=$_.UserPrincipalName
 $GuestCount++
 Write-Progress -Activity "`n     Processed mailbox count: $GuestCount "`n"  Currently Processing: $DisplayName"
 $GetCreationTime=$_.ExtensionProperty
 $CreationTime=$GetCreationTime.createdDateTime 
 $AccountAge= (New-TimeSpan -Start $CreationTime).Days


 $ObjectId=$_.ObjectId
 $Mail=$_.Mail

 #Getting guest user's group membership
 $Groups=(Get-AzureADUserMembership -ObjectId $ObjectId).DisplayName
 #$Groups
 $GroupMembership=""
 foreach($Group in $Groups)
 {
  #$Group
  if($GroupMembership -ne "")
  {
   $GroupMembership=$GroupMembership+","
  }
  $GroupMembership=$GroupMembership+$Group
 }
 if($GroupMembership -eq "")
 {
  $GroupMembership="-"
 }
 

 #Export result to CSV file 
 $PrintedGuests++
 $Result=@{'UserPrincipalName'=$upn;'DisplayName'=$DisplayName;'EmailAddress'=$Mail;'GroupMembership'=$GroupMembership} 
 $Output= New-Object PSObject -Property $Result 
 $Output | Select-Object DisplayName,UserPrincipalName,EmailAddress, GroupMembership | Export-Csv -Path $ExportCSV -Notype -Append
}
