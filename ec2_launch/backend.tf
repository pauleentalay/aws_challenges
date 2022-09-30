terraform {
  backend "s3" {
    bucket         = "ta-terraform-tfstates-247548036690"
    key            = "projects/movie_management_project/ec2_project.tfstates"
    dynamodb_table = "terraform-lock"
  }
}