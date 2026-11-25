# Configuracion del proveedor AWS
provider "aws" {
  region = var.region # Region donde se desplegaran los recursos
}

#Creamos el security group para las instancias
resource "aws_security_group" "mi-sg-efs-instancias-14" {
    name = "mi-security-group-terraform-efs-instancias"
    description = "grupo de seguridad para mi terraform instancias"
    vpc_id = "vpc-09ffffa328714b7dd"

}

#Creamos el security group para EFS
resource "aws_security_group" "mi-sg-efs-14" {
    name = "mi-security-group-terraform-efs"
    description = "grupo de seguridad para mi terraform efs"
    vpc_id = "vpc-09ffffa328714b7dd"

}

#Reglas de entrada SG instancias 

#entrada SSH
resource "aws_vpc_security_group_ingress_rule" "entrada_ssh_instancias" {
    security_group_id = aws_security_group.mi-sg-efs-instancias-14.id

    ip_protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_ipv4 = "0.0.0.0/0"

}

#Salida
#Salida a EFS 2049
resource "aws_vpc_security_group_egress_rule" "salida_efs" {
    security_group_id = aws_security_group.mi-sg-efs-instancias-14.id

    ip_protocol = "tcp"
    from_port = 2049
    to_port = 2049

    #Defino el destino
    referenced_security_group_id = aws_security_group.mi-sg-efs-14.id
  
}

#Salida a Internet all traffic
resource "aws_vpc_security_group_egress_rule" "salida_internet" {
    
    security_group_id = aws_security_group.mi-sg-efs-instancias-14.id

    ip_protocol = "-1"

    #destino
    cidr_ipv4 = "0.0.0.0/0"
  
}


#Reglas SG EFS
#Entrada
#Regla entrada EFS 2049
resource "aws_vpc_security_group_ingress_rule" "entrada_efs" {
    security_group_id = aws_security_group.mi-sg-efs-14.id

    ip_protocol = "tcp"
    from_port = 2049
    to_port = 2049
    
    #Origen
    referenced_security_group_id = aws_security_group.mi-sg-efs-instancias-14.id
}

#Salida
#No se requiere reglas de salida

# Declaracion de los recursos a aprovisionar de AWS
resource "aws_instance" "mi_instancia-efs" {
  ami           = var.ami_id
  instance_type = var.tipo_instancia
  key_name      = var.nombre_llave
  count         = var.cantidad_instancias

  tags = {
    Name = "Mi instancia EFS - ${count.index + 1}"
  }

  vpc_security_group_ids = [aws_security_group.mi-sg-efs-instancias-14.id] #asignamos el grupo de seguridad a la instancia
}
