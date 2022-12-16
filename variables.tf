variable "ecs_cluster_arn" {
  type        = string
  description = "The ARN of the ECS cluster where service will be provisioned"
}

variable "container_definition_json" {
  type        = string
  description = <<-EOT
    A string containing a JSON-encoded array of container definitions
    (`"[{ "name": "container1", ... }, { "name": "container2", ... }]"`).
    See [API_ContainerDefinition](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html),
    [cloudposse/terraform-aws-ecs-container-definition](https://github.com/cloudposse/terraform-aws-ecs-container-definition), or
    [ecs_task_definition#container_definitions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#container_definitions)
    EOT
}

variable "launch_type" {
  type        = string
  description = "The launch type on which to run your service. Valid values are `EC2` and `FARGATE`"
  default     = "EC2"
}

variable "task_placement_constraints" {
  type = list(object({
    type       = string
    expression = string
  }))
  default     = []
  description = <<-EOT
    A set of placement constraints rules that are taken into consideration during task placement.
    Maximum number of placement_constraints is 10. See [`placement_constraints`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#placement-constraints-arguments)
    EOT
}

variable "network_mode" {
  type        = string
  description = "The network mode to use for the task. This is required to be `awsvpc` for `FARGATE` `launch_type` or `null` for `EC2` `launch_type`"
  default     = null
}

variable "task_cpu" {
  type        = number
  description = "The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match supported memory values (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size)"
  default     = null
}

variable "task_memory" {
  type        = number
  description = "The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match supported cpu value (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size)"
  default     = null
}

variable "task_exec_role_arn" {
  type        = any
  description = <<-EOT
    A `list(string)` of zero or one ARNs of IAM roles that allows the
    ECS/Fargate agent to make calls to the ECS API on your behalf.
    If the list is empty, a role will be created for you.
    DEPRECATED: you can also pass a `string` with the ARN, but that
    string must be known a "plan" time.
    EOT
  default     = []
}

variable "task_exec_policy_arns" {
  type        = list(string)
  description = "A list of IAM Policy ARNs to attach to the generated task execution role."
  default     = []
}

variable "task_role_arn" {
  type        = any
  description = <<-EOT
    A `list(string)` of zero or one ARNs of IAM roles that allows
    your Amazon ECS container task to make calls to other AWS services.
    If the list is empty, a role will be created for you.
    DEPRECATED: you can also pass a `string` with the ARN, but that
    string must be known a "plan" time.
    EOT
  default     = []
}

variable "task_policy_arns" {
  type        = list(string)
  description = "A list of IAM Policy ARNs to attach to the generated task role."
  default     = []
}

variable "cloudwatch_event_role_arn" {
  type        = any
  description = <<-EOT
    A `list(string)` of zero or one ARNs of IAM roles that allows
    your Amazon Cloudwatch event to make calls to the ECS API on your behalf.
    If the list is empty, a role will be created for you.
    DEPRECATED: you can also pass a `string` with the ARN, but that
    string must be known a "plan" time.
    EOT
  default     = []
}

variable "cloudwatch_event_policy_arns" {
  type        = list(string)
  description = "A list of IAM Policy ARNs to attach to the generated cloudwatch event role."
  default     = ["arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole"]
}

variable "runtime_platform" {
  type        = list(map(string))
  description = <<-EOT
    Zero or one runtime platform configurations that containers in your task may use.
    Map of strings with optional keys `operating_system_family` and `cpu_architecture`.
    See `runtime_platform` docs https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#runtime_platform
    EOT
  default     = []
}

variable "efs_volumes" {
  type = list(object({
    host_path = string
    name      = string
    efs_volume_configuration = list(object({
      file_system_id          = string
      root_directory          = string
      transit_encryption      = string
      transit_encryption_port = string
      authorization_config = list(object({
        access_point_id = string
        iam             = string
      }))
    }))
  }))

  description = "Task EFS volume definitions as list of configuration objects. You cannot define both Docker volumes and EFS volumes on the same task definition."
  default     = []
}

variable "docker_volumes" {
  type = list(object({
    host_path = string
    name      = string
    docker_volume_configuration = list(object({
      autoprovision = bool
      driver        = string
      driver_opts   = map(string)
      labels        = map(string)
      scope         = string
    }))
  }))

  description = "Task docker volume definitions as list of configuration objects. You can define multiple Docker volumes on the same task definition, but a single volume can only have one `docker_volume_configuration`."
  default     = []
}

variable "fsx_volumes" {
  type = list(object({
    host_path = string
    name      = string
    fsx_windows_file_server_volume_configuration = list(object({
      file_system_id = string
      root_directory = string
      authorization_config = list(object({
        credentials_parameter = string
        domain                = string
      }))
    }))
  }))

  description = "Task FSx volume definitions as list of configuration objects. You can define multiple FSx volumes on the same task definition, but a single volume can only have one `fsx_windows_file_server_volume_configuration`."
  default     = []
}

variable "proxy_configuration" {
  type = object({
    type           = string
    container_name = string
    properties     = map(string)
  })
  description = "The proxy configuration details for the App Mesh proxy. See `proxy_configuration` docs https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html#proxy-configuration-arguments"
  default     = null
}

variable "permissions_boundary" {
  type        = string
  description = "A permissions boundary ARN to apply to the 3 roles that are created."
  default     = ""
}

variable "use_old_arn" {
  type        = bool
  description = "A flag to enable/disable tagging the ecs resources that require the new arn format"
  default     = false
}

variable "exec_enabled" {
  type        = bool
  description = "Specifies whether to enable Amazon ECS Exec for the tasks within the service"
  default     = false
}

variable "ephemeral_storage_size" {
  type        = number
  description = "The number of GBs to provision for ephemeral storage on Fargate tasks. Must be greater than or equal to 21 and less than or equal to 200"
  default     = 0

  validation {
    condition     = var.ephemeral_storage_size == 0 || (var.ephemeral_storage_size >= 21 && var.ephemeral_storage_size <= 200)
    error_message = "The ephemeral_storage_size value must be inclusively between 21 and 200."
  }
}

variable "role_tags_enabled" {
  type        = string
  description = "Enable/disable tags on ECS roles"
  default     = true
}

variable "schedule_expression" {
  type        = string
  default     = ""
  description = "The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule_expression or event_pattern is required. Can only be used on the default event bus."
}

variable "is_enabled" {
  type        = bool
  description = "Whether the rule should be enabled."
  default     = true
}

variable "task_count" {
  type        = number
  description = "The number of tasks to create based on the TaskDefinition."
  default     = null
}
