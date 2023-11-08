resource "aws_key_pair" "hostober-keypair" {
  key_name   = var.aws_keypair_name
  public_key = file(var.public_key_path)
}
