#Collecting Credentials
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."

#VMParameters
$vmParams = @{
ResourceGroupName = 'tamal'
Name = 'PSVM1'
Location = 'westus3'
Size = 'Standard_DS1_v2'
ImageName = 'Win2016Datacenter'
PublicIpAddressName = 'PSVM1PublicIp'
Credential = $cred
OpenPorts = 3389, 80
}

#Creating VM
$newVM1 = New-AzVM @vmParams

#output
$newVM1