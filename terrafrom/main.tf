resource "azurerm_resource_group" "example" {
  name     = "Insein-AKS-rg"
  location = "Southeast Asia"
}

resource "azurerm_kubernetes_cluster" "example" {
  name                = "insein-aks1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  dns_prefix          = "insein-aks"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_F2s_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.example.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.example.kube_config_raw

  sensitive = true
}