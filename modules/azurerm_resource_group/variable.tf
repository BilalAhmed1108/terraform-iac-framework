variable "rgs" {
  description = "Name of all the resource groups of the project"
  type = map(object({
    name=string
    location=string
    managed_by=optional(string)
    tags=optional(map(string))
  }))
}