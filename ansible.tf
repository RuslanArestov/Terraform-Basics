resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl",
    {
      webservers = yandex_compute_instance.web,
      databases  = yandex_compute_instance.db_vms,
      storage    = [yandex_compute_instance.storage]
    }
  )

  filename = "${abspath(path.module)}/hosts.ini"
}

variable "web_provision" {
  type        = bool
  default     = true
  description = "ansible provision switch variable"
}

resource "null_resource" "web_hosts_provision" {
  count = var.web_provision == true ? 1 : 0
  
  depends_on = [yandex_compute_instance.web, yandex_compute_instance.db_vms, yandex_compute_instance.storage]

  provisioner "local-exec" {
    command    = "> ~/.ssh/known_hosts &&eval $(ssh-agent) && cat ~/.ssh/terraform_study | ssh-add -"
    on_failure = continue

  }

  #Запуск ansible-playbook
  provisioner "local-exec" {
   
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i ${abspath(path.module)}/hosts.ini --private-key ~/.ssh/terraform_study ${abspath(path.module)}/test.yml"

    on_failure  = continue
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }

  }
  triggers = {
    always_run      = "${timestamp()}"
    always_run_uuid = "${uuid()}"
  }

}