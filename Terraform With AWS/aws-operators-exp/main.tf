variable "num_list" {
  type    = list(number)
  default = [1, 2, 3]
}

variable "employee_details" {
  type = list(object({
    fname = string
    lname = string
  }))

  default = [
    {
      fname = "Virat"
      lname = "Kohli"
    },
    {
      fname = "Keshav"
      lname = "Poojary"
    }
  ]
}

locals {
  mul    = 2 * 2
  double = [for num in var.num_list : num * 2]
  fnames = [for names in var.employee_details : names.fname]
}

output "res" {
  value = local.fnames
}

output "double_list" {
  value = local.double
}

output "mul_result" {
  value = local.mul
}

output "length" {
  value = length(var.num_list)
}
