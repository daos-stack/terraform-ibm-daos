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


resource "ibm_is_network_acl" "allow_all" {
  name           = "${var.name}-allow-all-acl"
  vpc            = ibm_is_vpc.daos.id
  resource_group = data.ibm_resource_group.daos.id
  rules {
    name        = "egress"
    action      = "allow"
    source      = "0.0.0.0/0"
    destination = "0.0.0.0/0"
    direction   = "outbound"
  }
  rules {
    name        = "ingress"
    action      = "allow"
    source      = "0.0.0.0/0"
    destination = "0.0.0.0/0"
    direction   = "inbound"
  }
}

resource "ibm_is_public_gateway" "daos" {
  count          = length(data.ibm_is_zones.regional_zones.zones)
  name           = "${var.name}-gw-${count.index + 1}"
  vpc            = ibm_is_vpc.daos.id
  zone           = data.ibm_is_zones.regional_zones.zones[count.index]
  resource_group = data.ibm_resource_group.daos.id
}

resource "ibm_is_subnet" "daos" {
  count                    = length(data.ibm_is_zones.regional_zones.zones)
  name                     = "${var.name}-${data.ibm_is_zones.regional_zones.zones[count.index]}-sn"
  vpc                      = ibm_is_vpc.daos.id
  zone                     = data.ibm_is_zones.regional_zones.zones[count.index]
  resource_group           = data.ibm_resource_group.daos.id
  total_ipv4_address_count = var.subnet_total_ipv4_address_count
  network_acl              = ibm_is_network_acl.allow_all.id
  public_gateway           = ibm_is_public_gateway.daos[count.index].id
}

resource "ibm_is_security_group" "bastion" {
  name           = "${var.name}-bastion-sg"
  vpc            = ibm_is_vpc.daos.id
  resource_group = data.ibm_resource_group.daos.id
}

resource "ibm_is_security_group_rule" "bastion_egress_all" {
  group     = ibm_is_security_group.bastion.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

resource "ibm_is_security_group_rule" "bastion_ingress_ssh" {
  for_each  = { for allowed_ip in var.bastion_ssh_allowed_ips : allowed_ip.cidr => allowed_ip }
  group     = ibm_is_security_group.bastion.id
  direction = "inbound"
  remote    = each.value.cidr
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group" "instance" {
  name           = "${var.name}-instance-sg"
  vpc            = ibm_is_vpc.daos.id
  resource_group = data.ibm_resource_group.daos.id
}

resource "ibm_is_security_group_rule" "instance_ingress" {
  count     = length(data.ibm_is_zones.regional_zones.zones)
  group     = ibm_is_security_group.instance.id
  direction = "inbound"
  remote    = ibm_is_subnet.daos[count.index].ipv4_cidr_block
  tcp {
    port_min = 1
    port_max = 65535
  }
}

resource "ibm_is_security_group_rule" "instance_egress" {
  group     = ibm_is_security_group.instance.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}
