# Josh Gold
# Creates a CSV report for enabled users, with various attributes, including a multi-value attribute

Import-Module ActiveDirectory

#For better performance with large Active Directory tasks, changing to the AD drive
set-location ad:

$filePath = "C:\temp\enabled_accounts.csv"

$StaffOU = "OU=EMPLOYEES,OU=BOSTON,DC=ad,DC=FABRIKAM"

# Get enabled users for a certain organizational unit, and export results to a CSV file
Get-ADUser -filter { enabled -eq $true } -properties DisplayName, DepartmentNumber, emailaddress, LocationNumber `
    -SearchBase $OU | Select-Object DisplayName, DepartmentNumber, emailaddress, @{name = "LocationNumber"; expression = { $_.LocationNumber -join ";" } } `
    | Export-Csv -path $filePath

    # LocationNumber can have multiple values, see more info here https://www.365admin.com.au/2018/04/how-to-force-powershell-to-export-multi.html