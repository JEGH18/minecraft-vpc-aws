output "public_ip" {
  description = "Public IP of the Minecraft server."
  value       = aws_instance.minecraft.public_ip
}

output "public_dns" {
  description = "Public DNS name of the Minecraft server."
  value       = aws_instance.minecraft.public_dns
}

output "minecraft_address" {
  description = "Address to use in the Minecraft client."
  value       = "${aws_instance.minecraft.public_dns}:${var.minecraft_port}"
}

output "ssh_command" {
  description = "Example SSH command (update the key path)."
  value       = "ssh -i /path/to/private_key ubuntu@${aws_instance.minecraft.public_dns}"
}
