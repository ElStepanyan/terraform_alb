resource "aws_lb" "tr_alb" {
  name               = "tr-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = [aws_subnet.tr_subnet_1.id, aws_subnet.tr_subnet_2.id]

  tags = {
    Environment = "tf"
  }
}

resource "aws_lb_target_group" "tr_alb_tg" {
  name     = "tr-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.tr_vpc.id
}

resource "aws_lb_listener" "tr_alb_listener" {
  load_balancer_arn = aws_lb.tr_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tr_alb_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "wp_1" {
  target_group_arn = aws_lb_target_group.tr_alb_tg.arn
  target_id        = aws_instance.wp_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "wp_2" {
  target_group_arn = aws_lb_target_group.tr_alb_tg.arn
  target_id        = aws_instance.wp_2.id
  port             = 80
}

