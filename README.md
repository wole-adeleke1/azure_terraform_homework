# Azure Terraform Homework!

**Task**

You have 3 Azure Subscriptions (We shall refer to them as Subscription A, B and C)
In "Subscription A" there is a NSG which contains rules that have already been placed in there 

In all the resources in Subscription B and C need to access the whole VNET of Subscription B over Port 80 so we will need to add a rule the NSG in Subscription A to allow the subnet that is used with the VNET in Subscription B and C

Both Subscription B and C use a Module called Networking which is where the change need to be made at the moment the priority is set to 100 but this is already in use so the Networking Module needs to be updated to find the next free number in the NSG within Subscription 1 when it is called

Once the priority has been set this should not change when a plan is ran again so if the rule is created with priority 101 it would stay as 101 when terraform runs again

*Dummy Subscription ID's have been provided but can be changed 