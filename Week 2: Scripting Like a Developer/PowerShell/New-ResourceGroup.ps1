function New-ResourceGroup {
    [cmdletbinding()]

    param (
        [parameter(Mandatory)]
        [string]$rgName,

        [Parameter(Mandatory)]
        [string]$location
                
    )

    $params = @{
        'Name' = $rgName
        'Location' = $location

    }
    
    New-AzResourceGroup @params

}
