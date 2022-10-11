/**
 * Copyright 2022 Intel Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}

data "ibm_is_region" "region" {
  name = var.region
}

data "ibm_is_zone" "zone" {
  name   = var.zone
  region = data.ibm_is_region.region.name
}

data "ibm_resource_group" "example_rg" {
  name = "Default"
}

resource "ibm_is_vpc" "example_vpc" {
  name                        = "${var.vpc_prefix}-vpc"
  resource_group              = data.ibm_resource_group.example_rg.id
  default_network_acl_name    = "${var.vpc_prefix}-default-acl"
  default_security_group_name = "${var.vpc_prefix}-default-sg"
  default_routing_table_name  = "${var.vpc_prefix}-default-rt"

}

resource "ibm_is_vpc_address_prefix" "example" {
  cidr = var.ipv4_cidr_block
  name = "${var.vpc_prefix}-addr-prefix"
  vpc  = ibm_is_vpc.example_vpc.id
  zone = var.zone
}

resource "ibm_is_subnet" "example_sn" {
  depends_on = [
    ibm_is_vpc_address_prefix.example
  ]
  name            = "${var.vpc_prefix}-sn"
  vpc             = ibm_is_vpc.example_vpc.id
  zone            = data.ibm_is_zone.zone.name
  ipv4_cidr_block = var.ipv4_cidr_block
  resource_group  = data.ibm_resource_group.example_rg.id
  public_gateway  = ibm_is_public_gateway.example_gw.*.id[0]
}

resource "ibm_is_network_acl" "example_acl" {
  name = "${var.vpc_prefix}-allow-all-acl"
  vpc  = ibm_is_vpc.example_vpc.id
  rules {
    name        = "outbound"
    action      = "allow"
    source      = "0.0.0.0/0"
    destination = "0.0.0.0/0"
    direction   = "outbound"
  }
  rules {
    name        = "inbound"
    action      = "allow"
    source      = "0.0.0.0/0"
    destination = "0.0.0.0/0"
    direction   = "inbound"
  }
}

resource "ibm_is_security_group" "example_sg" {
  name           = "${var.vpc_prefix}-sg"
  vpc            = ibm_is_vpc.example_vpc.id
  resource_group = data.ibm_resource_group.example_rg.id
}

resource "ibm_is_security_group_rule" "example_sgr_tcp_all" {
  for_each  = { for allowed_ip in var.security_group_ssh_allowed_ips : allowed_ip.cidr => allowed_ip }
  group     = ibm_is_security_group.example_sg.id
  direction = "inbound"
  remote    = each.value.cidr

  tcp {
    port_min = 1
    port_max = 65535
  }
}

# Have to enable the outbound traffic here. Default is off
resource "ibm_is_security_group_rule" "example_egr_all" {
  group     = ibm_is_security_group.example_sg.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

resource "ibm_is_public_gateway" "example_gw" {
  name           = "${var.vpc_prefix}-gw"
  vpc            = ibm_is_vpc.example_vpc.id
  zone           = data.ibm_is_zone.zone.name
  resource_group = data.ibm_resource_group.example_rg.id

  timeouts {
    create = "90m"
  }
}
