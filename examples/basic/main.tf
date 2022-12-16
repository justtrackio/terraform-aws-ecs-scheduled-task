module "container_definition" {
  source           = "cloudposse/ecs-container-definition/aws"
  version          = "0.58.1"
  container_name   = "hello-world"
  container_image  = "hello-world:latest"
  container_memory = 32
}

module "example" {
  source = "../.."

  name                      = "hello-world"
  container_definition_json = "[${module.container_definition.json_map_encoded}]"
  ecs_cluster_arn           = "arn:aws:ecs:eu-central-1:123456789123:cluster/my-cluster"
  schedule_expression       = "cron(* * * * ? *)"
}
