variable "s3" {
  type = string
  default = ""
}

variable "Git_connection" {
  type = string
  default = ""
}

variable "pipeline_name" {
  type = list(string)
}


variable "repository" {
  type = map(string)
  default = {
    "Reponame" = "BranchName"
  }
}