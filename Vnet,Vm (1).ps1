Connect-AzAccount -Tenant '2358adda-9b85-4370-b529-fbc0284268bd'

#RG,Vnet,Subnet,NSG,VM
#RGParameters
$rgParams = @{
Name = 'PSRG'
Location = 'eastus'
}
#Create New Resource Group
$rg = New-AzResourceGroup @rgParams
$rg

#VnetParams
$vnetParams = @{
Name = 'PSVNet'
ResourceGroupName = $rg.ResourceGroupName
Location = $rg.Location
AddressPrefix = '192.168.0.0/16'
}
#CreateVnet
$psvnet = New-AzVirtualNetwork @vnetParams
$psvnet

#NSGparams
$nsgParams = @{
Name = 'PSnsg'
ResourceGroupName = $rg.ResourceGroupName
Location = $rg.Location
}
#CreateNSG
$psnsg = New-AzNetworkSecurityGroup @nsgparams
$psnsg

#SubnetParams
$subnetParams = @{
Name = 'PSsubnet'
VirtualNetwork = $psvnet
AddressPrefix = '192.168.1.0/24'
NetworkSecurityGroup = $psnsg
}
#CreateSubnet
$pssubnet = Add-AzVirtualNetworkSubnetConfig @subnetParams
$pssubnet

#Collecting Credentials
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."

#VMParameters
$vmParams = @{
ResourceGroupName = $rg.ResourceGroupName
Name = 'PSVM1'
Location = $rg.Location
Size = 'Standard_B1s'
ImageName = 'Win2012R2Datacenter'
VirtualNetworkName = $psvnet
SubnetName = $pssubnet
SecurityGroupName = $psnsg
PublicIpAddressName = 'PSVM1PublicIp'
Credential = $cred
OpenPorts = 3389, 80
}

#Creating VM
$newVM1 = New-AzVM @vmParams

#output
$newVM1

