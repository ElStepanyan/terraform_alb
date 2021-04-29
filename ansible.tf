resource "null_resource" "install_env" {

  provisioner "local-exec" {
    command = "ansible-playbook -u ubuntu ../wordpress.yml"
  }

  depends_on = [aws_instance.wp_1, aws_instance.wp_2]

}
