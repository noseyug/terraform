terraform {
  backend "s3" {
    bucket       = "applyhubhuhu"
    key          = "terraform/dev/terraform.tfstate"
    region       = "ap-southeast-1"
    encrypt      = true
    use_lockfile = true
  }
}
