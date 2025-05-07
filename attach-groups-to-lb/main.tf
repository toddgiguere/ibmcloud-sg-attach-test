# ATTACH the 3 security groups to ALB, in parallel

resource "ibm_is_security_group_target" "sg_target_1" {
  security_group = var.security_group_1_id
  target         = var.alb_id
}

resource "ibm_is_security_group_target" "sg_target_2" {
  security_group = var.security_group_2_id
  target         = var.alb_id
}

resource "ibm_is_security_group_target" "sg_target_3" {
  security_group = var.security_group_3_id
  target         = var.alb_id
}
