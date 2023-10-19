# Application Load Balancer (ALB)
resource "aws_lb" "ALB" {
  name               = "test-lb"
  internal           = false
  load_balancer_type = "network"
  subnets            =  [aws_subnet.subnet1_public.id , aws_subnet.subnet2_public.id]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}