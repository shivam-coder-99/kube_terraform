terraform {
  backend "s3" {
    bucket       = "tf-eks-backend-ppd"
    key          = "backend/ToDO-App.tfstate"
    region       = "us-east-1"
    use_lockfile = true
  }
}

