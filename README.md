# terraform-aws-ecs-scheduled-task
Terraform module which creates a scheduled ecs task

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.30.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudwatch_label"></a> [cloudwatch\_label](#module\_cloudwatch\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_exec_label"></a> [exec\_label](#module\_exec\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_task_label"></a> [task\_label](#module\_task\_label) | cloudposse/label/null | 0.25.0 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_event_rule.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_ecs_task_definition.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.cloudwatch_event](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.ecs_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.cloudwatch_event](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.ecs_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.ecs_ssm_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.cloudwatch_event](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.ecs_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.cloudwatch_event](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_ssm_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ecs_task_exec](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.event](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_cloudwatch_event_policy_arns"></a> [cloudwatch\_event\_policy\_arns](#input\_cloudwatch\_event\_policy\_arns) | A list of IAM Policy ARNs to attach to the generated cloudwatch event role. | `list(string)` | <pre>[<br>  "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceEventsRole"<br>]</pre> | no |
| <a name="input_cloudwatch_event_role_arn"></a> [cloudwatch\_event\_role\_arn](#input\_cloudwatch\_event\_role\_arn) | A `list(string)` of zero or one ARNs of IAM roles that allows<br>your Amazon Cloudwatch event to make calls to the ECS API on your behalf.<br>If the list is empty, a role will be created for you.<br>DEPRECATED: you can also pass a `string` with the ARN, but that<br>string must be known a "plan" time. | `any` | `[]` | no |
| <a name="input_container_definition_json"></a> [container\_definition\_json](#input\_container\_definition\_json) | A string containing a JSON-encoded array of container definitions<br>(`"[{ "name": "container1", ... }, { "name": "container2", ... }]"`).<br>See [API\_ContainerDefinition](https://docs.aws.amazon.com/AmazonECS/latest/APIReference/API_ContainerDefinition.html),<br>[cloudposse/terraform-aws-ecs-container-definition](https://github.com/cloudposse/terraform-aws-ecs-container-definition), or<br>[ecs\_task\_definition#container\_definitions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#container_definitions) | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_docker_volumes"></a> [docker\_volumes](#input\_docker\_volumes) | Task docker volume definitions as list of configuration objects. You can define multiple Docker volumes on the same task definition, but a single volume can only have one `docker_volume_configuration`. | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    docker_volume_configuration = list(object({<br>      autoprovision = bool<br>      driver        = string<br>      driver_opts   = map(string)<br>      labels        = map(string)<br>      scope         = string<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_ecs_cluster_arn"></a> [ecs\_cluster\_arn](#input\_ecs\_cluster\_arn) | The ARN of the ECS cluster where service will be provisioned | `string` | n/a | yes |
| <a name="input_efs_volumes"></a> [efs\_volumes](#input\_efs\_volumes) | Task EFS volume definitions as list of configuration objects. You cannot define both Docker volumes and EFS volumes on the same task definition. | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    efs_volume_configuration = list(object({<br>      file_system_id          = string<br>      root_directory          = string<br>      transit_encryption      = string<br>      transit_encryption_port = string<br>      authorization_config = list(object({<br>        access_point_id = string<br>        iam             = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_ephemeral_storage_size"></a> [ephemeral\_storage\_size](#input\_ephemeral\_storage\_size) | The number of GBs to provision for ephemeral storage on Fargate tasks. Must be greater than or equal to 21 and less than or equal to 200 | `number` | `0` | no |
| <a name="input_exec_enabled"></a> [exec\_enabled](#input\_exec\_enabled) | Specifies whether to enable Amazon ECS Exec for the tasks within the service | `bool` | `false` | no |
| <a name="input_fsx_volumes"></a> [fsx\_volumes](#input\_fsx\_volumes) | Task FSx volume definitions as list of configuration objects. You can define multiple FSx volumes on the same task definition, but a single volume can only have one `fsx_windows_file_server_volume_configuration`. | <pre>list(object({<br>    host_path = string<br>    name      = string<br>    fsx_windows_file_server_volume_configuration = list(object({<br>      file_system_id = string<br>      root_directory = string<br>      authorization_config = list(object({<br>        credentials_parameter = string<br>        domain                = string<br>      }))<br>    }))<br>  }))</pre> | `[]` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_is_enabled"></a> [is\_enabled](#input\_is\_enabled) | Whether the rule should be enabled. | `bool` | `true` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_orders"></a> [label\_orders](#input\_label\_orders) | Overrides the `labels_order` for the different labels to modify ID elements appear in the `id` | <pre>object({<br>    cloudwatch = optional(list(string)),<br>    iam        = optional(list(string))<br>  })</pre> | `{}` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | The launch type on which to run your service. Valid values are `EC2` and `FARGATE` | `string` | `"EC2"` | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | The network mode to use for the task. This is required to be `awsvpc` for `FARGATE` `launch_type` or `null` for `EC2` `launch_type` | `string` | `null` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | A permissions boundary ARN to apply to the 3 roles that are created. | `string` | `""` | no |
| <a name="input_proxy_configuration"></a> [proxy\_configuration](#input\_proxy\_configuration) | The proxy configuration details for the App Mesh proxy. See `proxy_configuration` docs https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html#proxy-configuration-arguments | <pre>object({<br>    type           = string<br>    container_name = string<br>    properties     = map(string)<br>  })</pre> | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_role_tags_enabled"></a> [role\_tags\_enabled](#input\_role\_tags\_enabled) | Enable/disable tags on ECS roles | `string` | `true` | no |
| <a name="input_runtime_platform"></a> [runtime\_platform](#input\_runtime\_platform) | Zero or one runtime platform configurations that containers in your task may use.<br>Map of strings with optional keys `operating_system_family` and `cpu_architecture`.<br>See `runtime_platform` docs https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#runtime_platform | `list(map(string))` | `[]` | no |
| <a name="input_schedule_expression"></a> [schedule\_expression](#input\_schedule\_expression) | The scheduling expression. For example, cron(0 20 * * ? *) or rate(5 minutes). At least one of schedule\_expression or event\_pattern is required. Can only be used on the default event bus. | `string` | `""` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_task_count"></a> [task\_count](#input\_task\_count) | The number of tasks to create based on the TaskDefinition. | `number` | `null` | no |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | The number of CPU units used by the task. If using `FARGATE` launch type `task_cpu` must match supported memory values (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | `number` | `null` | no |
| <a name="input_task_exec_policy_arns"></a> [task\_exec\_policy\_arns](#input\_task\_exec\_policy\_arns) | A list of IAM Policy ARNs to attach to the generated task execution role. | `list(string)` | `[]` | no |
| <a name="input_task_exec_role_arn"></a> [task\_exec\_role\_arn](#input\_task\_exec\_role\_arn) | A `list(string)` of zero or one ARNs of IAM roles that allows the<br>ECS/Fargate agent to make calls to the ECS API on your behalf.<br>If the list is empty, a role will be created for you.<br>DEPRECATED: you can also pass a `string` with the ARN, but that<br>string must be known a "plan" time. | `any` | `[]` | no |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | The amount of memory (in MiB) used by the task. If using Fargate launch type `task_memory` must match supported cpu value (https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definition_parameters.html#task_size) | `number` | `null` | no |
| <a name="input_task_placement_constraints"></a> [task\_placement\_constraints](#input\_task\_placement\_constraints) | A set of placement constraints rules that are taken into consideration during task placement.<br>Maximum number of placement\_constraints is 10. See [`placement_constraints`](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition#placement-constraints-arguments) | <pre>list(object({<br>    type       = string<br>    expression = string<br>  }))</pre> | `[]` | no |
| <a name="input_task_policy_arns"></a> [task\_policy\_arns](#input\_task\_policy\_arns) | A list of IAM Policy ARNs to attach to the generated task role. | `list(string)` | `[]` | no |
| <a name="input_task_role_arn"></a> [task\_role\_arn](#input\_task\_role\_arn) | A `list(string)` of zero or one ARNs of IAM roles that allows<br>your Amazon ECS container task to make calls to other AWS services.<br>If the list is empty, a role will be created for you.<br>DEPRECATED: you can also pass a `string` with the ARN, but that<br>string must be known a "plan" time. | `any` | `[]` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |
| <a name="input_use_old_arn"></a> [use\_old\_arn](#input\_use\_old\_arn) | A flag to enable/disable tagging the ecs resources that require the new arn format | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_exec_role_arn"></a> [exec\_role\_arn](#output\_exec\_role\_arn) | The ECS execution role ARN |
| <a name="output_exec_role_name"></a> [exec\_role\_name](#output\_exec\_role\_name) | The ECS execution role name |
| <a name="output_exec_role_policy_id"></a> [exec\_role\_policy\_id](#output\_exec\_role\_policy\_id) | The ECS execution role policy ID, in the form of `role_name:role_policy_name` |
| <a name="output_exec_role_policy_name"></a> [exec\_role\_policy\_name](#output\_exec\_role\_policy\_name) | The ECS execution role policy name |
| <a name="output_exec_role_unique_id"></a> [exec\_role\_unique\_id](#output\_exec\_role\_unique\_id) | The ECS execution role unique id |
| <a name="output_task_definition_arn"></a> [task\_definition\_arn](#output\_task\_definition\_arn) | The ECS task definition ARN |
| <a name="output_task_definition_family"></a> [task\_definition\_family](#output\_task\_definition\_family) | The ECS task definition family |
| <a name="output_task_definition_revision"></a> [task\_definition\_revision](#output\_task\_definition\_revision) | The ECS task definition revision |
| <a name="output_task_role_arn"></a> [task\_role\_arn](#output\_task\_role\_arn) | The ECS task role ARN |
| <a name="output_task_role_id"></a> [task\_role\_id](#output\_task\_role\_id) | The ECS task role id |
| <a name="output_task_role_name"></a> [task\_role\_name](#output\_task\_role\_name) | The ECS task role name |
| <a name="output_task_role_unique_id"></a> [task\_role\_unique\_id](#output\_task\_role\_unique\_id) | The ECS task role unique id |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
