## Create Scheduled Actions
### Create Scheduled Action-1: Increase capacity during business hours
resource "aws_autoscaling_schedule" "increase_capacity_9am" {
  scheduled_action_name  = "increase-capacity-9am"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 8
  start_time             = "2030-03-30T11:00:00Z" # Time should be provided in UTC Timezone (11am UTC = 7AM EST)
  recurrence             = "00 09 * * *"
  autoscaling_group_name = aws_autoscaling_group.asg-app1.id 
}
### Create Scheduled Action-2: Decrease capacity during business hours
resource "aws_autoscaling_schedule" "decrease_capacity_5pm" {
  scheduled_action_name  = "decrease-capacity-5pm"
  min_size               = 2
  max_size               = 10
  desired_capacity       = 2
  start_time             = "2030-03-30T21:00:00Z" # Time should be provided in UTC Timezone (9PM UTC = 5PM EST)
  recurrence             = "00 21 * * *"
  autoscaling_group_name = aws_autoscaling_group.asg-app1.id
}

# resource "aws_autoscaling_schedule" "increase_capacity_9am_for_app2" {
#   scheduled_action_name  = "increase-capacity-9am-app2"
#   min_size               = 2
#   max_size               = 10
#   desired_capacity       = 8
#   start_time             = "2030-03-30T11:00:00Z" # Time should be provided in UTC Timezone (11am UTC = 7AM EST)
#   recurrence             = "00 09 * * *"
#   autoscaling_group_name = aws_autoscaling_group.asg-app2.id 
# }
# ### Create Scheduled Action-2: Decrease capacity during business hours
# resource "aws_autoscaling_schedule" "decrease_capacity_5pm_app2" {
#   scheduled_action_name  = "decrease-capacity-5pm-app2"
#   min_size               = 2
#   max_size               = 10
#   desired_capacity       = 2
#   start_time             = "2030-03-30T21:00:00Z" # Time should be provided in UTC Timezone (9PM UTC = 5PM EST)
#   recurrence             = "00 21 * * *"
#   autoscaling_group_name = aws_autoscaling_group.asg-app2.id
# }

# resource "aws_autoscaling_schedule" "increase_capacity_9am-app3" {
#   scheduled_action_name  = "increase-capacity-9am-app3"
#   min_size               = 2
#   max_size               = 10
#   desired_capacity       = 8
#   start_time             = "2030-03-30T11:00:00Z" # Time should be provided in UTC Timezone (11am UTC = 7AM EST)
#   recurrence             = "00 09 * * *"
#   autoscaling_group_name = aws_autoscaling_group.asg-app3.id 
# }
# ### Create Scheduled Action-2: Decrease capacity during business hours
# resource "aws_autoscaling_schedule" "decrease_capacity_5pm-app3" {
#   scheduled_action_name  = "decrease-capacity-5pm-app3"
#   min_size               = 2
#   max_size               = 10
#   desired_capacity       = 2
#   start_time             = "2030-03-30T21:00:00Z" # Time should be provided in UTC Timezone (9PM UTC = 5PM EST)
#   recurrence             = "00 21 * * *"
#   autoscaling_group_name = aws_autoscaling_group.asg-app3.id
# }