# inspired-az-tf-challenge

This terraform script was built with the purpose of creating 4 resources:

* Azure Load Balancer
* Network Security Group
* Virtual Machine Scale Set
* Virtual Network

Along with deploying a NGINX container inside each VMSS instance.

To run the script, please create a *.tfvars file with at least the following variables:

* resource_group_name
* ssh_key

It is configured to use az cli credentials, so please do an az login before running the script.
