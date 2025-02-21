{{- define "ai.imageName" -}}
{{- print "registry.cn-hangzhou.aliyuncs.com/mtphotos/mt-photos-ai:latest" -}}
{{- end -}}

{{/*
Retrieve ai credentials for environment variables configuration
*/}}
{{- define "ai.envVariableConfiguration" -}}
{{ if .Values.aiEnabled }}
{{ $envList := list }}
{{ $envList = mustAppend $envList (dict "name" "API_AUTH_KEY" "value" .Values.ai_api) }}         
{{ include "common.containers.environmentVariables" (dict "environmentVariables" $envList) }}
{{- end -}}
{{- end -}}