#resource "spotinst_subscription" "default-subscription" {
#
#    count = length(var.spot_subscription_events)
#
#    resource_id = spotinst_ocean_aws.this.id
#    event_type  = var.spot_subscription_events[ count.index ]
#    protocol    = "aws-sns"
#    endpoint    = var.notification_sqs_arn
#
#}
