variable "project_name" {
  type        = string
  description = "Name prefix for resources."
  default     = "minecraft"
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy into."
  default     = "us-east-1"
}

variable "availability_zone" {
  type        = string
  description = "Optional AZ for the public subnet. Leave empty for AWS to choose."
  default     = ""
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type        = string
  description = "CIDR block for the public subnet."
  default     = "10.0.1.0/24"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type for the Minecraft server."
  default     = "t3.medium"
}

variable "root_volume_size" {
  type        = number
  description = "Root EBS volume size in GB."
  default     = 20
}

variable "minecraft_port" {
  type        = number
  description = "Minecraft server port."
  default     = 25565
}

variable "minecraft_max_players" {
  type        = number
  description = "Maximum player count."
  default     = 10
}

variable "minecraft_motd" {
  type        = string
  description = "Server MOTD."
  default     = "Minecraft on AWS"
}

variable "minecraft_server_url" {
  type        = string
  description = "URL to a vanilla server.jar (from the official Minecraft server download page)."

  validation {
    condition     = length(trim(var.minecraft_server_url)) > 0
    error_message = "minecraft_server_url must be set to a valid server.jar URL."
  }
}

variable "minecraft_xms" {
  type        = string
  description = "Initial JVM heap size."
  default     = "1G"
}

variable "minecraft_xmx" {
  type        = string
  description = "Maximum JVM heap size."
  default     = "2G"
}

variable "minecraft_cidr" {
  type        = string
  description = "CIDR range allowed to connect to Minecraft."
  default     = "0.0.0.0/0"
}

variable "ssh_cidr" {
  type        = string
  description = "CIDR range allowed to SSH."
  default     = "0.0.0.0/0"
}

variable "create_key_pair" {
  type        = bool
  description = "Whether to create an AWS key pair from a local public key."
  default     = true
}

variable "key_pair_name" {
  type        = string
  description = "Key pair name to create or use."
  default     = "minecraft-key"

  validation {
    condition     = length(trim(var.key_pair_name)) > 0
    error_message = "key_pair_name cannot be empty."
  }
}

variable "ssh_public_key_path" {
  type        = string
  description = "Path to the public key used when create_key_pair is true."
  default     = "~/.ssh/id_ed25519.pub"

  validation {
    condition     = !var.create_key_pair || length(trim(var.ssh_public_key_path)) > 0
    error_message = "ssh_public_key_path must be set when create_key_pair is true."
  }
}
