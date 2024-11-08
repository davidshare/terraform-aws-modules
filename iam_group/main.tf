resource "aws_iam_group" "this" {
  name = var.name
  path = var.path
}

resource "aws_iam_group_membership" "this" {
  count = length(var.users) > 0 ? 1 : 0
  name  = "${var.name}-membership"
  users = var.users
  group = aws_iam_group.this.name
}

resource "aws_iam_group_policy_attachment" "this" {
  count      = length(var.policies)
  group      = aws_iam_group.this.name
  policy_arn = var.policies[count.index]
}
