{{- define "redis.imageName" -}}
{{- print "bitnami/redis:7.2.4" -}}
{{- end -}}

{{/*
Retrieve redis credentials for environment variables configuration
*/}}
{{- define "redis.envVariableConfiguration" -}}
{{ $envList := list }}
{{ $envList = mustAppend $envList (dict "name" "ALLOW_EMPTY_PASSWORD" "value" "yes") }}         
{{ include "common.containers.environmentVariables" (dict "environmentVariables" $envList) }}
{{- end -}}