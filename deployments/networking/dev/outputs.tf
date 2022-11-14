output "app_subnet" {
    value = "${module.vpc.subnets_self_links[0]}"
}

output "shared_service_subnet" {
    value = "${module.vpc.subnets_self_links[1]}"
}

output "network_vpc_id" {
    value = "${module.vpc.network_id}"
}