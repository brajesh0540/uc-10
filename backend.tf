terraform {
    backend "s3" {
        bucket         = "my-terraform-state-bucket-brajesh"
        key            = "dev/terraform.tfstate"
        encrypt        = true
        region = "us-east-1"
      
    }
}