# Задание 1 

tflint

1. Отсутствует ограничение версии для provider "template", "local", "null", "vault". Указываем версию.
2. Использование ветки по умолчанию в источнике модуля. Нужно ипользовать конкретный тег или коммит.
3. Устаревшие интерполяционные выражения always_run = "${timestamp()}". Используем always_run = timestamp()
4. variable "default_cidr", variable "vpc_name" и variable "stage_cidr" задеклалированы, но не используются. Убираем их.

chekov

1. Не назначена группа безопасности ВМ
2. Использование ветки по умолчанию в источнике модуля.


# Задание 2

![Alt text](https://github.com/RuslanArestov/Terraform-Basics/blob/terraform-05/images/2-1.png) <br/>
![Alt text](https://github.com/RuslanArestov/Terraform-Basics/blob/terraform-05/images/2-2.png) <br/>
![Alt text](https://github.com/RuslanArestov/Terraform-Basics/blob/terraform-05/images/2-3.table.png) <br/>
![Alt text](https://github.com/RuslanArestov/Terraform-Basics/blob/terraform-05/images/2.error_terraform_console.png) <br/>
![Alt text](https://github.com/RuslanArestov/Terraform-Basics/blob/terraform-05/images/2.unlock_state.png)

# Задание 3

Ссылка на PR: ![Alt text] (https://github.com/RuslanArestov/Terraform-Basics/pull/1#issue-2797906044)


# Задание 4

![Alt text](https://github.com/RuslanArestov/Terraform-Basics/blob/terraform-05/images/4.validation_true.png) <br/>
![Alt text](https://github.com/RuslanArestov/Terraform-Basics/blob/terraform-05/images/4.validation_false.png)