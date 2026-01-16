resource "aws_vpc_endpoint_policy" "this" {
  vpc_endpoint_id = var.vpc_endpoint_id
  policy          = var.policy

  # Optional region override (rarely needed, but supported)
  # Note: Terraform provider alias must be passed explicitly if used
}

# Validation: Ensure policy is valid JSON if provided
locals {
  # If policy is null, we skip validation (means "full access" default)
  decoded_policy = var.policy != null ? jsondecode(var.policy) : null

  # Human-readable name for tagging or reference
  endpoint_name = var.endpoint_name != null ? var.endpoint_name : "unknown"
}

resource "null_resource" "policy_validation" {
  count = var.policy != null ? 1 : 0

  triggers = {
    policy_hash = sha256(var.policy)
  }

  lifecycle {
    precondition {
      condition     = try(local.decoded_policy.Version == "2012-10-17" || local.decoded_policy.Version == "2008-10-17", false)
      error_message = "IAM policy must have Version '2012-10-17' or '2008-10-17'."
    }

    precondition {
      condition     = try(length(local.decoded_policy.Statement) > 0, false)
      error_message = "IAM policy must contain at least one Statement."
    }
  }
}

# Optional: Attach tags via separate resource if needed
# (aws_vpc_endpoint_policy does not support tags directly)