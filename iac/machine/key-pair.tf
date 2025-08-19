# =============================================================================
# # Key Pair Resource for AWS EC2 Instances
# =============================================================================

resource "aws_key_pair" "key_pair" {
  key_name   = "${var.instance_key_pair}_key_pair"
  public_key = file(var.instance_key_pair_location)

  tags = merge(
    {
      Name = "${var.instance_key_pair}_key_pair"
    },
    var.tags
  )
}
