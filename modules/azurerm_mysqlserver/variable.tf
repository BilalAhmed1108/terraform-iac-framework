variable "sqlserver" {
    type =map(object({
        name                         = string
        resource_group_name          = string
        location                     = string
        version                      = string
        sql_password                  = string
        sql_username                  = string
        minimum_tls_version          = optional(string)
        administrator_login_password_wo = optional(string)
        administrator_login_password_wo_version = optional(string)
        connection_policy            = optional(string)
        express_vulnerability_assessment_enabled = optional(bool)
        transparent_data_encryption_key_vault_key_id = optional(string)
        public_network_access_enabled = optional(bool)
        outbound_traffic_enabled     = optional(bool)
        primary_user_assigned_identity_id = optional(string)
        identity = optional(object({
            type = string
            identity_ids = optional(list(string))
        }))
        azuread_administrator = optional(object({
            login_username = string
            object_id      = string
            tenant_id      = optional(string)
            azuread_authentication_only = optional(bool)
        }))
        tags = optional(map(string))
    }))
  
}

variable "keyvaultid" {
    type = map(object({
        r_g_n = string
        name  = string
    }))
  
}

variable "kvsec" {
    type = map(object({
       kvid = string
        name  = string
    }))
  
}

