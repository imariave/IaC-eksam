#$tenantid = "02feabb9-444e-4f66-9c13-6a8f04b75c2f"
#$subscriptionid = "efc1e7b1-5729-4eea-b33e-12cc6b1c0183"
#$credentials = Get-Credential
#Connect-AzAccount -ServicePrincipal -Credential $credentials -TenantId $tenantid -Environment AzureCloud -SubscriptionId $subscriptionid


$rg = "monetsinRG-12132021"
New-AzResourceGroup -Name $rg -Location "West Europe" -Force


New-AzResourceGroupDeployment `
    -Name "test-envMariave-12132021" `
    -ResourceGroupName $rg `
    -TemplateFile '.\eksamen\test-servA-template.json' `
    #-TemplateFile '.\eksamen\tslq-template.json' `
    #-TemplateParameterFile '.\eksamen\tsql-parametersFile.json' `
-TemplateFile '.\eksamen\test-SP-template.json' `
    -TemplateParameterFile '.\eksamen\test-SP-parameters.json' `
    -TemplateFile '.\eksamen\arm-webapp.json' `
    -TemplateParameterFile '.\eksamen\webapp-parameters.json'

New-AzResourceGroupDeployment `
    -Name "dev-marias-deployment-webapp" `
    -ResourceGroupName $rg `
    -TemplateFile '.\arm-webapp.json' `
    -TemplateParameterFile '.\webapp-parameters.json'


New-AzResourceGroupDeployment `
    -Name "prod-envMariave-12132021-02" `
    -ResourceGroupName $rg `
    -TemplateFile '.\test-servA-template.json'


New-AzResourceGroupDeployment `
    -Name "dev-marias-sql-deploy" `
    -ResourceGroupName $rg `
    -TemplateFile '.\sql-template.json' `
    -TemplateParameterFile '.\sql-parameters.json'



Remove-AzResourceGroup -name "monetsinRG-12132021" -Force:$true

Remove-AzResourceGroupDeployment -Name "dev-marias-deployment-sql"
#Remove-AzResourceGroupDeployment -name "environment-test-12132021" -Force:$true