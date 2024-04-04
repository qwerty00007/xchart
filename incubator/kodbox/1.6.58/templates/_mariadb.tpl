{{- define "mariadb.imageName" -}}
{{- print "linuxserver/mariadb:10.11.6" -}}
{{- end -}}

{{/*
Retrieve mariadb credentials for environment variables configuration
*/}}
{{- define "mariadb.envVariableConfiguration" -}}
{{ $envList := list }}
{{ $envList = mustAppend $envList (dict "name" "MYSQL_ROOT_PASSWORD" "value" .Values.dbRootPass) }}         
{{ $envList = mustAppend $envList (dict "name" "MYSQL_DATABASE" "value" .Values.dbName) }}
{{ $envList = mustAppend $envList (dict "name" "MYSQL_USER" "value" .Values.dbUser) }}         
{{ $envList = mustAppend $envList (dict "name" "MYSQL_PASSWORD" "value" .Values.dbPass) }}
{{ $envList = mustAppend $envList (dict "name" "PUID" "value" (printf "%d" (.Values.ownerUID | int))) }}
{{ $envList = mustAppend $envList (dict "name" "PGID" "value" (printf "%d" (.Values.ownerGID | int))) }}
{{ include "common.containers.environmentVariables" (dict "environmentVariables" $envList) }}
{{- end -}}


{{/*
Retrieve mariadb volume configuration
*/}}
{{- define "mariadb.volumeConfiguration" -}}
{{ include "common.storage.configureAppVolumes" (dict "appVolumeMounts" .Values.mariadbAppVolumeMounts "emptyDirVolumes" .Values.emptyDirVolumes "ixVolumes" .Values.ixVolumes) | nindent 0 }}
{{- end -}}


{{/*
Retrieve mariadb volume mounts configuration
*/}}
{{- define "mariadb.volumeMountsConfiguration" -}}
{{ include "common.storage.configureAppVolumeMountsInContainer" (dict "appVolumeMounts" .Values.mariadbAppVolumeMounts ) | nindent 0 }}
{{- end -}}

