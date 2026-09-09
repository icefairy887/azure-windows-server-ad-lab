@{
    Azure = @{
        ResourceGroupName = 'rg-adlab'
        Location          = 'centralus'
        VirtualNetwork    = 'vnet-adlab'
        VirtualNetworkCidr = '10.10.0.0/16'
        SubnetName        = 'snet-ad'
        SubnetCidr        = '10.10.1.0/24'
        NetworkSecurityGroup = 'nsg-dc01'
        PublicIpName      = 'pip-dc01'
        NetworkInterface = 'nic-dc01'
        VmName            = 'DC01'
        VmSize            = 'Standard_B2s'
        PrivateIpAddress  = '10.10.1.4'
        ImagePublisher    = 'MicrosoftWindowsServer'
        ImageOffer        = 'WindowsServer'
        ImageSku          = '2025-datacenter-azure-edition'
        ImageVersion      = 'latest'
    }

    ActiveDirectory = @{
        DomainName  = 'corp.brookelab.test'
        NetBIOSName = 'BROOKELAB'
        RootOuName  = 'Brookelab'
        ChildOus    = @('Users', 'Groups', 'Workstations', 'Servers', 'Service Accounts')
    }
}

