resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bar_instance" {
  # Example of an explicit dependency. Can be on an entire module or a specific resource in this
  # or another module.
  depends_on = ["module.storage"]

  ami           = "${lookup(var.aws_linux_2_amis, var.region)}"
  key_name      = "${var.ssh_key_name}"
  instance_type = "t2.micro"
  monitoring    = true
  vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

  # - By default provisioners that fail will cause "terraform apply" to fail. This can be overridden
  #   with 'on_failure = "continue"'.
  # - Provisioners can also run on destruction with 'when = "destroy"'
  # - You can specify multiple provisioners, they are run in the order they are specified.
  # - Valid types are: chef, file (copy files/dirs), habitat, local-exec, remote-exec (ssh),
  #                    salt-masterless
  provisioner "local-exec" {
    command = <<EOL
sleep ${var.ansible_wait_sec}; \
ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook \
-u ec2-user \
--private-key '${var.ssh_key_path}/${var.ssh_key_name}.pem' \
--inventory '${self.private_ip},' \
--extra-vars 'redblack=${var.tag_redblack} ssh_key_path=${var.ssh_key_path} ssh_key_name=${var.ssh_key_name} ' \
../../modules/barsys/ansible/barsys.yml
EOL
  }

  tags {
    Environment = "${var.environment}"
    Name = "${var.tag_name_prefix}-bar-instance-${var.red_black}"
  }
}
