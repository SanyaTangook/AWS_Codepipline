/*------------variable---------------- */
variable "role" {
  type = string
  default = "AWSPipeline-Role"
}

variable "policy" {
  type = string
  default = "AWSCodePipelineServiceRole"
}