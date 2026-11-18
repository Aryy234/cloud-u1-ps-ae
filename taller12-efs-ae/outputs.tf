output "ids_instancias" {
    description = "IDs de las instancias creadas"
    value = aws_instance.mi_instancia-efs[*].id
}

output "cantidad_instancias" {
    description = "Cantidad de instancias creadas"
    value = length(aws_instance.mi_instancia-efs)
}

output "ip_publica_instancias" {
    description = "Direcciones IP públicas de las instancias creadas"
    value = aws_instance.mi_instancia-efs[*].public_ip
}

output "zona_disponibilidad" {
    description = "Zona de disponibilidad de las instancias creadas"
    value = aws_instance.mi_instancia-efs[*].availability_zone
}