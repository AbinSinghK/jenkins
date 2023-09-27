terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 4.18.0"
   }
 }

 backend "s3" {
   bucket = "abin2001"
   key    = "mumbai"
   region = "ap-south-1"
 }
}
