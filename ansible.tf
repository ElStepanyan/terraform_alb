provisioner "local-exec" {
    command = "ansible-playbook -u ubuntu ../wordpress.yml"
}
