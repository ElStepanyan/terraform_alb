resource "null_resource" "install_env" {

  provisioner "local-exec" {
    command = "( cd epam_trainig_ansible_roles && ansible-playbook -u ubuntu wordpress.yml)"
  }

  depends_on = [aws_instance.wp_1, aws_instance.wp_2]

}
