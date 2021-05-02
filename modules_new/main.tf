module "mytestserver" {
source = "/root/mymodules/ec2/"
region = "us-east-1"
myami = "ami-048f6ed62451373d9"
servername = "dvsserver"
mykeyname = "aruna_nvirg_key1"
servertype = "t2.micro"

}
