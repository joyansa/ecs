region                     = "us-east-1"
vpc_name                   = "gcs-vpc"
vpc_cidr            = "10.0.0.0/16"
igw_name                   = "gcs-igw"
public_subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidr_blocks = ["10.0.10.0/24", "10.0.11.0/24"]
rt_name                    = "gcs-rt"
project_name               = "gcs"
environment                = "stage"
architecture               = "X86_64"
container_image            = "nginx:latest"