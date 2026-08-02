# AWS Infrastructure (Terraform)

Provisions a minimal, self-contained AWS environment for hosting a single-node
Kubernetes-ready Ubuntu EC2 instance.

## Resources created
- VPC
- 1 public subnet (auto-assigns public IPs)
- Internet Gateway
- Route table + association (routes `0.0.0.0/0` → IGW)
- Security group allowing:
  - SSH (22)
  - HTTP (80)
  - HTTPS (443)
  - Kubernetes NodePort range (30000–32767)
- 1 Ubuntu 22.04 LTS EC2 instance (`t2.medium` by default)

## Prerequisites
- Terraform >= 1.5.0
- AWS credentials configured (env vars, `~/.aws/credentials`, or SSO)
- An existing EC2 key pair in the target region (for SSH access)

## Usage

```bash
cp terraform.tfvars.example terraform.tfvars
# edit terraform.tfvars: set key_name, and ideally lock ssh_allowed_cidr to your IP

terraform init
terraform plan
terraform apply
```

After apply, connect with:

```bash
terraform output ssh_connection_command
```

## Notes / production hardening
- `ssh_allowed_cidr` defaults to `0.0.0.0/0` for convenience — restrict it to
  your own IP (e.g. `1.2.3.4/32`) before using this anywhere beyond a lab/demo.
- Instance type defaults to `t2.medium`; bump `instance_type` in
  `terraform.tfvars` if you need more headroom for a Kubernetes control plane
  (e.g. `t3.large`).
- Only one AZ/subnet is created, matching the "one public subnet" requirement.
  Extend `vpc.tf` with additional subnets/AZs if you need HA later.
- No NAT Gateway is created since the instance is public and doesn't need
  private outbound-only resources.

## Teardown

```bash
terraform destroy
```
