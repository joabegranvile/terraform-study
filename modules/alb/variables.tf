variable "environment" {
	type = string
}

variable "project" {
	type = string
}

variable "public_subnets_ids" {
	type = list(string)
}

variable "vpc_id" {
	type = string
}

variable "acm_certificate_arn" {
	type = string
	description = "Arn para lb publico"
}

variable "secundary_api_certificates" {
	description = "list of lb to create"
	type = list(object({
		name 		= string
		certificate_arn = string
	}))
	default = []
}
