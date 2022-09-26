#A file like this should generally be discluded from git, but is left here as an example

variable "sudo_password" {
  type      = string
  default   = "ubuntu"
  sensitive = true
}