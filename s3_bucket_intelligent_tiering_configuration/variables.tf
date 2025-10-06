variable "bucket" {
  type = string
}

variable "name" {
  type = string
}

variable "tiering" {
  type = list(object({
    days        = number
    access_tier = string # ARCHIVE_ACCESS or DEEP_ARCHIVE_ACCESS
  }))
}

variable "filter" {
  type = object({
    prefix = optional(string)
    tags   = optional(map(string))
  })
  default = null
}