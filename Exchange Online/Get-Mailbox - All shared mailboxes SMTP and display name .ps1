#Status: TESTED

#Module: ExchangeOnlineManagement
#Module Version: 
#Modified date: 21.05.07
#Permissions: Exchange
#Command: Get-Mailbox
#Purpose and use case: To extract all shared mailboxes from Office 365

 
Get-Mailbox -RecipientTypeDetails SharedMailbox -ResultSize Unlimited | select PrimarySmtpAddress,DisplayName |  export-csv c:\temp\SharedMailboxes.csv
