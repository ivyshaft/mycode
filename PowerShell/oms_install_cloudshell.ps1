az vm extension set --resource-group [RGNAME] --vm-name [hostname] --name OmsAgentForLinux --publisher Microsoft.EnterpriseCloud.Monitoring --protected-settings '{"workspaceKey":"myWorkspaceKey"}' --settings '{"workspaceId":"[workspaceid]","skipDockerProviderInstall": true}' --version 1.14.23

