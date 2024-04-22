{{- define "df.imageName" -}}
{{- print "mtphotos/mt-photos-deepface:1.0.1" -}}
{{- end -}}

{{/*
Retrieve df credentials for environment variables configuration
*/}}
{{- define "df.envVariableConfiguration" -}}
{{ if .Values.dfEnabled }}
{{ $envList := list }}
{{ $envList = mustAppend $envList (dict "name" "API_AUTH_KEY" "value" .Values.df_api) }}         
{{ include "common.containers.environmentVariables" (dict "environmentVariables" $envList) }}
{{- end -}}
{{- end -}}