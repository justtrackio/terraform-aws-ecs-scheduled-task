output "exec_role_policy_id" {
  description = "The ECS execution role policy ID, in the form of `role_name:role_policy_name`"
  value       = try(aws_iam_role_policy.ecs_exec[0].id, "")
}

output "exec_role_policy_name" {
  description = "The ECS execution role policy name"
  value       = try(aws_iam_role_policy.ecs_exec[0].name, "")
}

output "exec_role_name" {
  description = "The ECS execution role name"
  value       = try(aws_iam_role.ecs_exec[0].name, "")
}

output "exec_role_arn" {
  description = "The ECS execution role ARN"
  value       = length(local.task_exec_role_arn) > 0 ? local.task_exec_role_arn : try(aws_iam_role.ecs_exec[0].arn, "")
}

output "exec_role_unique_id" {
  description = "The ECS execution role unique id"
  value       = try(aws_iam_role.ecs_exec[0].unique_id, "")
}

output "task_role_name" {
  description = "The ECS task role name"
  value       = try(aws_iam_role.ecs_task[0].name, "")
}

output "task_role_arn" {
  description = "The ECS task role ARN"
  value       = length(local.task_role_arn) > 0 ? local.task_role_arn : try(aws_iam_role.ecs_task[0].arn, "")
}

output "task_role_id" {
  description = "The ECS task role id"
  value       = try(aws_iam_role.ecs_task[0].id, "")
}

output "task_role_unique_id" {
  description = "The ECS task role unique id"
  value       = try(aws_iam_role.ecs_task[0].unique_id, "")
}

output "task_definition_family" {
  description = "The ECS task definition family"
  value       = try(aws_ecs_task_definition.default[0].family, "")
}

output "task_definition_revision" {
  description = "The ECS task definition revision"
  value       = try(aws_ecs_task_definition.default[0].revision, "")
}

output "task_definition_arn" {
  description = "The ECS task definition ARN"
  value       = try(aws_ecs_task_definition.default[0].arn, "")
}
