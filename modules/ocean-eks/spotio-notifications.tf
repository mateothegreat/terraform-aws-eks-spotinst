resource "spotinst_subscription" "default-subscription" {

    count = var.notification_sqs_arn != null ? length(var.spot_subscription_events) : 0

    resource_id = spotinst_ocean_aws.this.id
    event_type  = var.spot_subscription_events[ count.index ]
    protocol    = "aws-sns"
    endpoint    = var.notification_sqs_arn

}
