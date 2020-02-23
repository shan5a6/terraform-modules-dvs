# working with modules

module "storage" {
	source = "./s3"
	mys3bucket_name = "dvs-devops1"

}

module "network" {

	source = "./vpc"
	myvpc_name = "dvs-vpc"
	myvpc_cidr = "10.124.0.0/16"
	myigw_name = "dvsigw"
	myroute_name = "dvsroute"
	mypubsubnet_name = "dvspubsubnet"
	mypubsubnet_cidr = "10.124.10.0/24"
	mysecgroup_name	= "dvssg"

}

module "compute" {
	source = "./ec2"
	myserver_name = "DvsPubServer"
	keyname = "rajukey_nvirginia"
	instance_type = "t2.micro"
	vpcsgid = "${module.network.mysgid}"
	subnetid = "${module.network.mysubnetid}"

}
