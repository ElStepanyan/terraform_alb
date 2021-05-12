resource "null_resource" "install_env" {

  provisioner "local-exec" {
    command = "( cd epam_trainig_ansible_roles && ANSIBLE_HOST_KEY_CHECKING=false | ansible-playbook -u ubuntu wordpress.yml)"
  }

  depends_on = [aws_instance.wp_1, aws_instance.wp_2]

}
