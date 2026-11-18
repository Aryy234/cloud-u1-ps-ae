# Configuracion del proveedor AWS
provider "aws" {
  region = var.region # Region donde se desplegaran los recursos
}

#Creamos el security group para las instancias
resource "aws_security_group" "mi-sg-efs-instancias" {
    name = "mi-security-group-terraform-efs-instancias"
    description = "grupo de seguridad para mi terraform instancias"
    vpc_id = "vpc-09ffffa328714b7dd"

    #reglas de entrada
    #ssh
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #http
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #reglas de salida
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

#Creamos el security group para EFS
resource "aws_security_group" "mi-sg-efs" {
    name = "mi-security-group-terraform-efs"
    description = "grupo de seguridad para mi terraform efs"
    vpc_id = "vpc-09ffffa328714b7dd"

    #reglas de entrada
    #nfs (puerto 2049 desde el security group de las instancias)
    ingress {
        from_port = 2049
        to_port = 2049
        protocol = "tcp"
        security_groups = [aws_security_group.mi-sg-efs-instancias.id]
    }

    #reglas de salida
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

}

# Declaracion de los recursos a aprovisionar de AWS
resource "aws_instance" "mi_instancia-efs" {
  ami           = var.ami_id
  instance_type = var.tipo_instancia
  key_name      = var.nombre_llave
  count         = var.cantidad_instancias

  tags = {
    Name = "Mi instancia EFS - ${count.index + 1}"
  }

  vpc_security_group_ids = [aws_security_group.mi-sg-efs-instancias.id] #asignamos el grupo de seguridad a la instancia
}
