resource "aws_s3_bucket_website_configuration" "this" {
  bucket = var.bucket
  expected_bucket_owner = var.expected_bucket_owner

  # Index Document Configuration
  dynamic "index_document" {
    for_each = var.index_document != null ? [var.index_document] : []
    content {
      suffix = index_document.value.suffix
    }
  }

  # Error Document Configuration  
  dynamic "error_document" {
    for_each = var.error_document != null ? [var.error_document] : []
    content {
      key = error_document.value.key
    }
  }

  # Redirect All Requests Configuration
  dynamic "redirect_all_requests_to" {
    for_each = var.redirect_all_requests_to != null ? [var.redirect_all_requests_to] : []
    content {
      host_name = redirect_all_requests_to.value.host_name
      protocol  = redirect_all_requests_to.value.protocol
    }
  }

  # Individual Routing Rules
  dynamic "routing_rule" {
    for_each = var.routing_rules != null ? [] : var.routing_rule
    content {
      dynamic "condition" {
        for_each = routing_rule.value.condition != null ? [routing_rule.value.condition] : []
        content {
          http_error_code_returned_equals = condition.value.http_error_code_returned_equals
          key_prefix_equals               = condition.value.key_prefix_equals
        }
      }

      redirect {
        host_name               = routing_rule.value.redirect.host_name
        http_redirect_code      = routing_rule.value.redirect.http_redirect_code
        protocol                = routing_rule.value.redirect.protocol
        replace_key_prefix_with = routing_rule.value.redirect.replace_key_prefix_with
        replace_key_with        = routing_rule.value.redirect.replace_key_with
      }
    }
  }

  # JSON Routing Rules
  routing_rules = var.routing_rules
}