########################################################################################################################
# Outputs
########################################################################################################################

output "vpc_id" {
  value = ibm_is_vpc.vpc.id
}

output "alb_id" {
  value = ibm_is_lb.alb.id
}

output "security_group_ids" {
  value = [
    ibm_is_security_group.securitygroup_1.id,
    ibm_is_security_group.securitygroup_2.id,
    ibm_is_security_group.securitygroup_3.id
  ]
}
