# AWS CloudTrail Setup

CloudTrail provides auditing and governance by recording AWS account activity.

## Setup Options

You can enable CloudTrail via the console or Terraform:

### Console:
1. Go to the CloudTrail service in the AWS Console.
2. Click “Create trail”.
3. Enable management events (read/write).
4. Set up an S3 bucket to store logs.

### Terraform (not implemented in this project):
For simplicity and cost-saving, CloudTrail setup is recommended via the console for free-tier users.
