########################################################################################################################
# Resource Group
########################################################################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.2.0"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

########################################################################################################################
# VPC + Subnet + Public Gateway
#
# NOTE: This is a very simple VPC with single subnet in a single zone with a public gateway enabled, that will allow
# all traffic ingress/egress by default.
# For production use cases this would need to be enhanced by adding more subnets and zones for resiliency, and
# ACLs/Security Groups for network security.
########################################################################################################################

resource "ibm_is_vpc" "vpc" {
  name                      = "${var.prefix}-vpc"
  resource_group            = module.resource_group.resource_group_id
  address_prefix_management = "auto"
  tags                      = var.resource_tags
}

resource "ibm_is_public_gateway" "gateway" {
  name           = "${var.prefix}-gateway-1"
  vpc            = ibm_is_vpc.vpc.id
  resource_group = module.resource_group.resource_group_id
  zone           = "${var.region}-1"
}

resource "ibm_is_subnet" "subnet_zone_1" {
  name                     = "${var.prefix}-subnet-1"
  vpc                      = ibm_is_vpc.vpc.id
  resource_group           = module.resource_group.resource_group_id
  zone                     = "${var.region}-1"
  total_ipv4_address_count = 256
  public_gateway           = ibm_is_public_gateway.gateway.id
}

# Add a basic ALB
resource "ibm_is_lb" "alb" {
  name    = "${var.prefix}-alb"
  subnets = [ibm_is_subnet.subnet_zone_1.id]
}

# Add some security groups
# (no rules needed for this example)
resource "ibm_is_security_group" "securitygroup_1" {
  name = "${var.prefix}-group-1"
  vpc  = ibm_is_vpc.vpc.id
}

resource "ibm_is_security_group" "securitygroup_2" {
  name = "${var.prefix}-group-2"
  vpc  = ibm_is_vpc.vpc.id
}

resource "ibm_is_security_group" "securitygroup_3" {
  name = "${var.prefix}-group-3"
  vpc  = ibm_is_vpc.vpc.id
}
