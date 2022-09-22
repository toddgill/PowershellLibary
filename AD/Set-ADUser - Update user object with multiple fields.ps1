## COMMENTS AND NOTES ##

# Run each of these lines indvidually
# Wait 5-10 minutes for each script to run before testing. Script will complete before processes behind-the-scenes will
# Refer to this guide for full details: https://statsllc.sharepoint.com/:w:/r/sites/IT-Knowledge/Shared%20Documents/01.%20NEW/DRAFT%20-%20Process%20and%20tools%20to%20update%20AD%20user%20data.docx?d=w1c5c41aa90574724ba269a585999313d&csf=1&web=1&e=MfcGwI


## UPDATE POWER BI REPORT AND BACK-UP ##

#Set Execution script
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

#Export all AD user data
Get-ADUser -Filter * -Properties * | export-csv "C:\Users\da.sparry\AD all users.csv"

#Back-up all info, for those you are specifically going to update, before you start making changes
Import-csv -path "Z:\AD and Oracle updates\AD update input template.csv" | ForEach-Object {$srcUser = $_; Get-ADUser -Identity $_.SAM -Properties * | Select userPrincipalName,Title,Department,Office,c,co,countrycode,MobilePhone,Manager} | Export-csv -path “Z:\AD and Oracle updates\$((Get-Date).ToString("yyMMdd")) Export of all user update info.csv” -NoTypeInformation



## COMMANDS ##

#Update Job Title and description
Import-csv -path "Z:\AD and Oracle updates\AD update input template.csv" | ForEach-Object {$srcUser = $_; Set-ADUser -Identity $_.SAM -Title $_.JobTitle -Description $_.JobTitle}

#Update Department
Import-csv -path "Z:\AD and Oracle updates\AD update input template.csv" | ForEach-Object {$srcUser = $_; Set-ADUser -Identity $_.SAM -Department $_.Department}

#Update Office
Import-csv -path "Z:\AD and Oracle updates\AD update input template.csv" | ForEach-Object {$srcUser = $_; Set-ADUser -Identity $_.SAM -Office $_.Office}

#Update Manager
Import-csv -path "Z:\AD and Oracle updates\AD update input template.csv" | ForEach-Object {$srcUser = $_; Set-ADUser -Identity $_.SAM -Manager $_.ManagerSAM}

#Update Mobile
Import-csv -path "Z:\AD and Oracle updates\AD update input template.csv" | ForEach-Object {$srcUser = $_; Set-ADUser -Identity $_.SAM -MobilePhone $_.Mobile}

#Update country in 3 distinct fields
Import-csv -path "Z:\AD and Oracle updates\AD update input template.csv" | ForEach-Object {$srcUser = $_; Set-ADUser -Identity $_.SAM -Replace @{c=($_.CountryISO);co=($_.Country);countrycode=($_.CountryNumeric)}}



## ADDITIONAL COMMANDS ##

#Update display email address
Import-csv -path "Z:\AD and Oracle updates\EmailAddressUpdate.csv" | ForEach-Object {$srcUser = $_; Set-ADUser -Identity $_.SAM -EmailAddress $_.EmailAddress}

#Update company
Import-csv -path "Z:\AD and Oracle updates\CompanyUpdate.csv" | ForEach-Object {$srcUser = $_; Set-ADUser -Identity $_.SAM -Company $_.Company}

#Update employee ID
Import-csv -path "Z:\AD and Oracle updates\EmployeeIDUpdate.csv" | ForEach-Object {$srcUser = $_; Set-ADUser -Identity $_.SAM -EmployeeID $_.EmployeeID}
