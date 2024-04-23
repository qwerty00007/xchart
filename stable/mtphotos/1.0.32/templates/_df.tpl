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
{{ $envList = mustAppend $envList (dict "name" "DETECTOR_BACKEND" "value" .Values.detector_backend) }}
{{ $envList = mustAppend $envList (dict "name" "RECOGNITION_MODEL" "value" .Values.recognition_model) }}
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

