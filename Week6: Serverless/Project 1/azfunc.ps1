function Create-AzFuncApp {
    # This is creating a Pwsh function to create an Azure Function
    param (
        # This creates parameters for use in the code. This makes the code reusable
        [parameter(Mandatory)]
        [string]$RGName,
        # This will prompt for the Resource Group Name

        [parameter(Mandatory)]
        [string]$name,
        # This wil prompt for the name we want to give our Azure Function

        [parameter(Mandatory)]
        [string]$storageAccountName
        # This will prompt for the storage account name we want to create
    )

    az storage account create --name $storageAccountName `
                              --resource-group $RGName

    $plan = az functionapp plan create -g $RGName `
                              -n $($name + 'plan') `
                              --min-instances 1 `
                              --max-burst 5 `
                              --sku EP1
    $plan

    az functionapp create -g $RGName `
                          -n $name `
                          -p $($name + 'plan') `
                          --runtime powershell `
                          -s $storageAccountName `
                          --functions-version 2
}
