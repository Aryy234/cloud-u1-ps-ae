
#Region donde se desplegaran los recursos
variable "region" {
    description = "The AWS region"
    type = string
    default = "us-east-1"
}

variable "ami_id" {
    description = "Id de la AMI"
    type = string
    default = "ami-0c230065b91270bc6"
}

variable "tipo_instancia" {
    description = "Tipo de instancia"
    type = string
    default = "t2.micro"
}

variable "nombre_llave" {
    description = "Nombre de la llave"
    type = string
    default = "mi-primera-llaves-ae"
} 

variable "cantidad_instancias" {
    description = "Cantidad de instancias"
    type = number
    default = 2
}

