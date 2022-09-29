#Collecting Credentials
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."

#VMParameters
$vmParams = @{
ResourceGroupName = 'htrg'
Name = 'PSVM1'
Location = 'eastus'
Size = 'Standard_B1s'
ImageName = 'Win2012R2Datacenter'
PublicIpAddressName = 'PSVM1PublicIp'
Credential = $cred
OpenPorts = 3389, 80
}

#Creating VM
$newVM1 = New-AzVM @vmParams

#output
$newVM1

