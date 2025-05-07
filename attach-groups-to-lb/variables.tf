########################################################################################################################
# Input variables
########################################################################################################################

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud api token"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "Region where resources are created"
}

variable "security_group_1_id" {
  type = string
}

variable "security_group_2_id" {
  type = string
}

variable "security_group_3_id" {
  type = string
}

variable "alb_id" {
  type = string
}
