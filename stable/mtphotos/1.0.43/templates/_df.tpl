{{- define "df.imageName" -}}
{{- print "crpi-gcuyquw9co62xzjn.cn-guangzhou.personal.cr.aliyuncs.com/devfox101/mt-photos-insightface-unofficial:latest" -}}
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


{{/*
Retrieve df volume configuration
*/}}
{{- define "df.volumeConfiguration" -}}
{{ include "common.storage.configureAppVolumes" (dict "appVolumeMounts" .Values.dfAppVolumeMounts "emptyDirVolumes" .Values.emptyDirVolumes "ixVolumes" .Values.ixVolumes) | nindent 0 }}
{{- end -}}


{{/*
Retrieve df volume mounts configuration
*/}}
{{- define "df.volumeMountsConfiguration" -}}
{{ include "common.storage.configureAppVolumeMountsInContainer" (dict "appVolumeMounts" .Values.dfAppVolumeMounts ) | nindent 0 }}
{{- end -}}

