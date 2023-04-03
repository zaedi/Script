$computers = Get-ADComputer -Filter *

foreach ($computer in $computers) {
    $employeeId = $computer.Name.Split("-")[-2]
    $user = Get-ADUser -Filter "EmployeeID -eq '$employeeId'"
    if ($user) {
        $logonWorkstations = $user.LogonWorkstations
        if ($logonWorkstations -notcontains $computer.Name) {
            $logonWorkstations += $computer.Name
            Set-ADUser -Identity $user -LogonWorkstations $logonWorkstations
        }
    }
}