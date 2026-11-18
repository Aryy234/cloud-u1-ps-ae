# Configuracion del proveedor AWS
provider "aws" {
  region = "us-east-1" # Region donde se desplegaran los recursos
}

#Creamos el security group
resource "aws_security_group" "mi-sg" {
    name = "mi-security-group-terraform"
    description = "grupo de seguridad para mi terraform"
    vpc_id = "vpc-09ffffa328714b7dd"

    #reglas de entrada
    #ssh
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

        ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    #reglas de salida
    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [ "0.0.0.0/0" ]
    }

  
}

# Declaracion de los recursos a aprovisionar de AWS
resource "aws_instance" "mi_instancia" {
  ami           = "ami-0c230065b91270bc6"
  instance_type = "t2.micro"
  key_name      = "mi-primera-llaves-ae"

  tags = {
    Name = "MiInstanciaTerraForm2"
  }

  vpc_security_group_ids = [aws_security_group.mi-sg.id] #asignamos el grupo de seguridad a la instancia
}

# En la terminal

/*

1. aws configure --ingresar al laboratorio
2. terraform init --inciar proyecto terraform solo se realiza una vez
3. terraform plan --ver el plan o configuracion del proyecto
4. terraform apply -- aplicar cambios
5. terraform destroy --para destruir esa instancia


*/