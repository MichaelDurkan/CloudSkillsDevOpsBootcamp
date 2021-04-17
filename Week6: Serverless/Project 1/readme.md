Open azfunc.ps1 file, copy all and paste into the Terminal. This creates the Function "CreateAzFuncApp".

Once this is done, run the following command to deploy the Azure Function to a Resource Group:

``Create-AzFuncApp -RGName 'CSBC-AZFUNCW6P1' -name 'mdcsbcfuncapp' -storageAccountName 'mdcsfuncstor649'``
