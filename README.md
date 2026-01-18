# minecraft-vpc-aws

Terraform to deploy a vanilla Minecraft server on AWS with a dedicated VPC and public subnet.

## Prerequisites
- Terraform >= 1.4
- AWS credentials with permissions for VPC, EC2, and related resources
- An SSH key pair (public key path used by Terraform)
- A vanilla `server.jar` download URL from the official Minecraft download page

## Configure AWS credentials (.env)
Copy the example file and fill in your credentials:

```bash
cp .env.example .env
```

Update `.env` with your values:

```
AWS_ACCESS_KEY_ID=...
AWS_SECRET_ACCESS_KEY=...
AWS_REGION=us-east-1
```

## Deploy
Initialize and apply using the helper script (loads `.env`).
You must pass `minecraft_server_url` from https://www.minecraft.net/en-us/download/server:

```bash
./scripts/terraform.sh init
./scripts/terraform.sh apply -var 'minecraft_server_url=PASTE_SERVER_JAR_URL_HERE'
```

## SSH key setup
By default, this creates an AWS key pair using the public key at `~/.ssh/id_ed25519.pub`.
If you want to use an existing AWS key pair instead:

```bash
./scripts/terraform.sh apply -var create_key_pair=false -var key_pair_name=YOUR_KEY_NAME -var 'minecraft_server_url=PASTE_SERVER_JAR_URL_HERE'
```

If you need a different public key path:

```bash
./scripts/terraform.sh apply -var ssh_public_key_path=/full/path/to/key.pub -var 'minecraft_server_url=PASTE_SERVER_JAR_URL_HERE'
```

## Outputs
Terraform outputs include the public IP/DNS and the Minecraft address to use in the client.

## Clean up
```bash
./scripts/terraform.sh destroy -var 'minecraft_server_url=PASTE_SERVER_JAR_URL_HERE'
```

## Notes
- Restrict `ssh_cidr` and `minecraft_cidr` to trusted IP ranges for better security.
- Increase `minecraft_xmx` for larger worlds or more players.
