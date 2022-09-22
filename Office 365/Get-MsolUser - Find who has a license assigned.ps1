#Status: Testing

#Module: Connect-MSolService
#Modified date: 2021/08/13
#PIM permissions: None
#Command: Get-MsolUser
#Purpose and use case: 
#Notes: Microsoft SKUs list: https://statsllc.sharepoint.com/:x:/r/sites/Office365Delivery/PowerBI/Licenses/Microsoft%20SKUs.xlsx?d=wbdc526441dbd432c82d03911e780130c&csf=1&web=1&e=b2I7KS
 

#Run first to have the export provide info on whether direct or via group
#Returns TRUE if the user has the license assigned directly
function UserHasLicenseAssignedDirectly
{
    Param([Microsoft.Online.Administration.User]$user, [string]$skuId)

    foreach($license in $user.Licenses)
    {
        #we look for the specific license SKU in all licenses assigned to the user
        if ($license.AccountSkuId -ieq $skuId)
        {
            #GroupsAssigningLicense contains a collection of IDs of objects assigning the license
            #This could be a group object or a user object (contrary to what the name suggests)
            #If the collection is empty, this means the license is assigned directly - this is the case for users who have never been licensed via groups in the past
            if ($license.GroupsAssigningLicense.Count -eq 0)
            {
                return $true
            }

            #If the collection contains the ID of the user object, this means the license is assigned directly
            #Note: the license may also be assigned through one or more groups in addition to being assigned directly
            foreach ($assignmentSource in $license.GroupsAssigningLicense)
            {
                if ($assignmentSource -ieq $user.ObjectId)
                {
                    return $true
                }
            }
            return $false
        }
    }
    return $false
}
#Returns TRUE if the user is inheriting the license from a group
function UserHasLicenseAssignedFromGroup
{
    Param([Microsoft.Online.Administration.User]$user, [string]$skuId)

    foreach($license in $user.Licenses)
    {
        #we look for the specific license SKU in all licenses assigned to the user
        if ($license.AccountSkuId -ieq $skuId)
        {
            #GroupsAssigningLicense contains a collection of IDs of objects assigning the license
            #This could be a group object or a user object (contrary to what the name suggests)
            foreach ($assignmentSource in $license.GroupsAssigningLicense)
            {
                #If the collection contains at least one ID not matching the user ID this means that the license is inherited from a group.
                #Note: the license may also be assigned directly in addition to being inherited
                if ($assignmentSource -ine $user.ObjectId)
                {
                    return $true
                }
            }
            return $false
        }
    }
    return $false
}

#Run second to select SKU

$skuId = "statsllc:STANDARDPACK"

#Run once SKU selected
Get-MsolUser -All | where {$_.isLicensed -eq $true -and $_.Licenses.AccountSKUID -eq $skuId} | select UserPrincipalName, ObjectId, @{Name="SkuId";Expression={$skuId}}, @{Name="AssignedDirectly";Expression={(UserHasLicenseAssignedDirectly $_ $skuId)}}, @{Name="AssignedFromGroup";Expression={(UserHasLicenseAssignedFromGroup $_ $skuId)}} | Export-csv -Path C:\Temp\Licences\STANDARDPACK.csv

