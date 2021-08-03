resource "aws_key_pair" "carlos_elv_key" {
  key_name   = "carlos_elv_key"
  public_key = file("./files/public_key")
  tags       = {
    project     = var.project,
    responsible = var.responsible
  }
}