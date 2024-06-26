#null resource
resource "null_resource" "null" {
  depends_on = [ module.ec2-instance-public ]

  connection {
    type = "ssh"
    host = aws_eip.elastic_ip.public_ip
    user = "ec2-user"
    # password = ""
    private_key = file("${path.module}/private_key/terraform-key.pem")
  }

  #file provisioner
  provisioner "file" {
    source = "private_key/terraform-key.pem"
    destination = "/tmp/terraform-key.pem"
  }

  #remote provisioner
  provisioner "remote-exec" {
    inline = [ 
        "sudo chmod 400 /tmp/terraform-key.pem"
     ]
  }

  #local provisioner
  #create time provision when=create
  provisioner "local-exec" {
    command = "echo VPC creation time local provisioner on ${date} and VPC ID: ${module.vpc.vpc_id} >> creation-vpc.txt"
    working_dir = "local-exec-outputs/"
    on_failure = continue
    when = create
  }

  #destroy time provisioner when=destroy
 /* provisioner "local-exec" {
    command = "echo VPC destroy time local provisioner on `date` and VPC ID: ${module.vpc.vpc_id} >> destroy-vpc.txt"
    working_dir = "local-exec-outputs/"
    on_failure = continue
    when = destroy
  }*/
}