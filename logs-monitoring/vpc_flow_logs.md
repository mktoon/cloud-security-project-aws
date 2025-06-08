# VPC Flow Logs Setup

VPC Flow Logs capture IP traffic going to and from network interfaces in your VPC.

## Steps to Enable (via AWS Console):

1. Go to the VPC Dashboard.
2. Choose your VPC > Flow Logs > Create Flow Log.
3. Destination: CloudWatch Logs or S3.
4. IAM Role: Create a role with permissions to publish logs.

## Useful for:
- Detecting suspicious traffic
- Auditing ingress/egress patterns
- Troubleshooting connectivity
