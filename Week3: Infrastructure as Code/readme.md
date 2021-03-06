# Week 3 Infrastructure as Code

The code found in this repository is to help you learn how to use ARM Templates to deploy resources in Azure, and Terraform to deploy resources in AWS.

## WIP
The code found in Week 3 Infrastructure as Code is currently a Work In Progress (WIP) and the readme will be updated when ready

## ARM Template

The ARM Template code found in Week 3 Infrastructure as Code is for anyone that wants to create an Ubuntu Virtual Machines in Azure

## How to Use the ARM Template
The ARM Template is created using the ARM Tools Extension in Visual Studio Code. A user can define parameters in the code, that can then be passed in whe running the Azure CLI commands to deploy the resources using the ARM Template. Therefore, the script can be re-used at any point for any environment.

## Example ARM Template
```
{
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "adminPassword": {
            "type": "string",
            "metadata": {
                "description": "Administrator Password"
            }
        }
    },
    "functions": [],
    "variables": {},
    "resources": [
        {
            "name": "[toLower('csdemosad98f7as9fastorage')]",
            "type": "Microsoft.Storage/storageAccounts",
            "apiVersion": "2019-06-01",
            "location": "[resourceGroup().location]",
            "tags": {
                "displayName": "csdemosad98f7as9fa Storage Account"
            },
            "sku": {
                "name": "Standard_LRS"
            },
            "kind": "Storage"
        },
        {
            "name": "csdemosad98f7as9fa-PublicIP",
            "type": "Microsoft.Network/publicIPAddresses",
            "apiVersion": "2019-11-01",
            "location": "[resourceGroup().location]",
            "tags": {
                "displayName": "PublicIPAddress"
            },
            "properties": {
                "publicIPAllocationMethod": "Dynamic",
                "dnsSettings": {
                    "domainNameLabel": "[toLower('csdemosad98f7as9fa')]"
                }
            }
        },
        {
            "name": "csdemosad98f7as9fa-nsg",
            "type": "Microsoft.Network/networkSecurityGroups",
            "apiVersion": "2018-08-01",
            "location": "[resourceGroup().location]",
            "properties": {
                "securityRules": [
                    {
                        "name": "nsgRule1",
                        "properties": {
                            "description": "description",
                            "protocol": "Tcp",
                            "sourcePortRange": "*",
                            "destinationPortRange": "22",
                            "sourceAddressPrefix": "*",
                            "destinationAddressPrefix": "*",
                            "access": "Allow",
                            "priority": 100,
                            "direction": "Inbound"
                        }
                    }
                ]
            }
        },
        {
            "name": "csdemosad98f7as9fa-VirtualNetwork",
            "type": "Microsoft.Network/virtualNetworks",
            "apiVersion": "2019-11-01",
            "location": "[resourceGroup().location]",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkSecurityGroups', 'csdemosad98f7as9fa-nsg')]"
            ],
            "tags": {
                "displayName": "csdemosad98f7as9fa-VirtualNetwork"
            },
            "properties": {
                "addressSpace": {
                    "addressPrefixes": [
                        "10.0.0.0/16"
                    ]
                },
                "subnets": [
                    {
                        "name": "csdemosad98f7as9fa-VirtualNetwork-Subnet",
                        "properties": {
                            "addressPrefix": "10.0.0.0/24",
                            "networkSecurityGroup": {
                                "id": "[resourceId('Microsoft.Network/networkSecurityGroups', 'csdemosad98f7as9fa-nsg')]"
                            }
                        }
                    }
                ]
            }
        },
        {
            "name": "csdemosad98f7as9fa-NetworkInterface",
            "type": "Microsoft.Network/networkInterfaces",
            "apiVersion": "2019-11-01",
            "location": "[resourceGroup().location]",
            "dependsOn": [
                "[resourceId('Microsoft.Network/publicIPAddresses', 'csdemosad98f7as9fa-PublicIP')]",
                "[resourceId('Microsoft.Network/virtualNetworks', 'csdemosad98f7as9fa-VirtualNetwork')]"
            ],
            "tags": {
                "displayName": "csdemosad98f7as9fa-NetworkInterface"
            },
            "properties": {
                "ipConfigurations": [
                    {
                        "name": "ipConfig1",
                        "properties": {
                            "privateIPAllocationMethod": "Dynamic",
                            "publicIPAddress": {
                                "id": "[resourceId('Microsoft.Network/publicIPAddresses', 'csdemosad98f7as9fa-PublicIP')]"
                            },
                            "subnet": {
                                "id": "[resourceId('Microsoft.Network/virtualNetworks/subnets', 'csdemosad98f7as9fa-VirtualNetwork', 'csdemosad98f7as9fa-VirtualNetwork-Subnet')]"
                            }
                        }
                    }
                ]
            }
        },
        {
            "name": "csdemosad98f7as9fa",
            "type": "Microsoft.Compute/virtualMachines",
            "apiVersion": "2019-07-01",
            "location": "[resourceGroup().location]",
            "dependsOn": [
                "[resourceId('Microsoft.Network/networkInterfaces', 'csdemosad98f7as9fa-NetworkInterface')]"
            ],
            "tags": {
                "displayName": "csdemosad98f7as9fa"
            },
            "properties": {
                "hardwareProfile": {
                    "vmSize": "Standard_A2_v2"
                },
                "osProfile": {
                    "computerName": "csdemosad98f7as9fa",
                    "adminUsername": "adminUsername",
                    "adminPassword": "[parameters('adminPassword')]"
                },
                "storageProfile": {
                    "imageReference": {
                        "publisher": "Canonical",
                        "offer": "UbuntuServer",
                        "sku": "16.04-LTS",
                        "version": "latest"
                    },
                    "osDisk": {
                        "name": "csdemosad98f7as9fa-OSDisk",
                        "caching": "ReadWrite",
                        "createOption": "FromImage"
                    }
                },
                "networkProfile": {
                    "networkInterfaces": [
                        {
                            "id": "[resourceId('Microsoft.Network/networkInterfaces', 'csdemosad98f7as9fa-NetworkInterface')]"
                        }
                    ]
                },
                "diagnosticsProfile": {
                    "bootDiagnostics": {
                        "enabled": true,
                        "storageUri": "[reference(resourceId('Microsoft.Storage/storageAccounts/', toLower('csdemosad98f7as9fastorage'))).primaryEndpoints.blob]"
                    }
                }
            }
        }
    ],
    "outputs": {
        "oublicIP": {
            "type": "string",
            "value": "[reference(resourceId('Microsoft.Network/publicIPAddresses', 'csdemosad98f7as9fa-PublicIP')).dnsSettings.fqdn]"
        }
    }
}

```
    

## Contributors
Michael Durkan
