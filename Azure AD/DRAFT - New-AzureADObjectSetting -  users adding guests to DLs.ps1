#NEED TO ADD A FOR EACH STATEMENT AND USE A .CSV EXPORT OF ALL GROUPS

#Status: UNTESTED

#Module: 
#Module Version: 
#Modified date: 
#PIM permissions: 
#Command: 
#Purpose and use case: 
#Template: 



$GroupName = "<GroupName>"

Connect-AzureAD

$template = Get-AzureADDirectorySettingTemplate | ? {$_.displayname -eq "group.unified.guest"}
$settingsCopy = $template.CreateDirectorySetting()
$settingsCopy["AllowToAddGuests"]=$False
$groupID= (Get-AzureADGroup -SearchString $GroupName).ObjectId
New-AzureADObjectSetting -TargetType Groups -TargetObjectId $groupID -DirectorySetting $settingsCopy
