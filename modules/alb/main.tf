resource "aws_security_group" "alb_public" {
	name 		= "alb-public-${var.project}-${var.environment}"
	description	= "ALB publico"
	vpc_id		= var.vpc_id


# Ingress: Https 443 de qualquer lugar
	ingress {
	description = "Allow HTTPS"
	from_part   = 443
	to_port	    = 443
	cidr_blocks = ["0.0.0.0/0"]
	}
	egress {
	description = "All outbound"
	from_port   = 0
	to_port	    = 0
	protocol    = "-1"
	cidr_blocks = ["0.0.0.0/0"]
	}
	tags = {
	Name 	    = "alb-public-${var-project}-${var.environment}"
	Environment = var.environment
	Project	    = var.project
	}
}



# Security group para o ALB privado
resource "aws_security_group" "alb_private" {
	name 	    = "alb-private-${var.project}-${var.environment}"
	description = "ALB privado"
	vpc_id	    = var.vpc_id

	ingress {
	description = "Allow HTTP from VPC"
	from_port   = 80
	to_port	    = 80
	protocol    = 80
	cidr_blocks = ["10.0.0.0/16"] # Use o CIDR da sua VPC
}
	egress {
	description = "All outbound"
	from_port   = 0
	to_port	    = 0
	protocol    = "-1"
	cidr_blocks = ["0.0.0.0/0"]
}
	tags = {
	Name 	    = "alb-private-${var.project}-${var.environment}"
	Environment = var.environment
	Project     = var.project
	}
}

# ALB público com lister para a porta 443(https)
resource "aws_lb" "public" {
	name        = "pulic-lb-${var.project}-${var.environment}"
	load_balancer_type	= "application"
	subnets	    = var.public_subnets_ids
	security_groups	= [aws_security_group.alb_public.id]
	tags = {
	Name        = "public-lb-${var.project}-${var.environment}"
	Environment = var.environment
	Project	    = var.project
	}
}

resource "aws_lb_listener" "public_https" {
	load_balancer_arn	= aws_lb.public.arn
	port			= 443
	protocol		= "HTTPS"
	ssl_policy		= "ELBSecurityPolicy-2016-08"
	certicate_arn		= var.acm_certificate_arn

	default_action {
	type = "fixed_response"
	fixed_response {
	content_type = "text/plain"
	message_body = "Forbidden"
	status_code  = "403"
		}
	} 
}

resource "aws_lb_listener_certificate" "secondary_certs" {
	for_each = {
	for cert_object in var.secondary_api_certificates : cert_object.certificate_arn = > cert_object
}
	listener_arn 	= aws_lb_listener.public_https.arn
	certificate_arn	= each.value.certificate_arn
}

# ALB privado com listener para porta 80(https)
resource "aws_lb" "private" {
	name = "private-lb-${var.project}-${var.environment}"
	load_balancer_type = "application"
	subnets		= var.private_subnets_ids
	internal 	= true
	security_groups = [aws_security_group.alb_private.id]
	tags = {
		Name = "private-lb-${var.project}-${var.environment}"
		Environment = var.environment
		Project = var.project
	}
}

resource "aws_lb_listener" "private_http" {
	load_balancer_arn = aws_lb.private.arn
	port		  = 80
	protocol	  = "HTTP"
	
	default_action {
		type = "fixed-response"
		fixed_response {
			content_type = "text/plain"
			message_body = "Forbidden"
			status_code  = "403"
}
	}
}
