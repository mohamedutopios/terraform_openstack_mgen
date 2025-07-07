environment           = "staging"
location              = "West Europe"
resource_group_name   = "rg-staging"
vnet_name             = "vnet-staging"
subnet_name           = "subnet-staging"
address_space         = ["10.20.0.0/16"]
subnet_prefix         = ["10.20.1.0/24"]
admin_username        = "azureuser"
admin_ssh_key         = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDgIrxL+pgvPRo8Jx2P38V9yxBGMWn8QEfzoIP3MaDsctyf58y4pCLdP0kSX48SiUzpor3aWnbgH/m5nPRnFdtPqlrUThbYs9hfMy3Jo3KVqrN0rP8ZMHZDpXKlrAfXxQYcPl5IXhd+LkrQucdDQfFOoD7H2nR1fDNx5DqcVRiQoojzBNw5PPE8mGOpXh1rhQOY6+j3Yt+RtTiwgofiMoMHPKVNOSCUntUEMS9bq0rA1i+U41zMX+v7jaRzVt8t8uDOQX45caiZvFDQ76QkllZkxap0Es9jbMfgB2PYBMaRQ1tlpyjNBCRKo9iUwGa06+/ty8TTmDeDkZ+hvsD0Jz32o9UF0HWhWatQa4g3iT95tvwR5M0dZYgFvuCrla1EQVLuhXSTuE3CSFAJE58Gz11IojwgPrdFbZf6zqZI1Y5dD8c7zs00IbTm8B3PQDOSyITIfY2LeEWdqDtXLcnY1TqU2F0mgjfUrALcJTfxRgfBVlJvMMonw0OE+fZVKPZrnj2210EmqIbYfOOUzOONNw6o7bB3qqZuRRyln5rrYW7wIu/9/Ndhl3Vt1KvApy35fROZX2i3Cn2BCEurp+TAFpEUapS4voU5rvtmxav7ZkRREbgmSs0OgSTKrh62UtvtsEekDoGmeDal0n2cY+L2tvChwGaNzN0C0qHjkooetwL+7w== azureuser@terraform"
vm_name               = "vm-staging"
vm_size               = "Standard_B2s"