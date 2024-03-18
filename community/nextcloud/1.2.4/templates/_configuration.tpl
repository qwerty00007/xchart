{{- define "nextcloud.configuration" -}}

  {{- $fullname := (include "ix.v1.common.lib.chart.names.fullname" $) -}}

  {{- $dbHost := (printf "%s-mariadb" $fullname) -}}
  {{- $dbUser := .Values.nextcloudConfig.dbUser -}}
  {{- $dbName := .Values.nextcloudConfig.dbName -}}

  {{- $dbPass := .Values.nextcloudConfig.dbPass -}}
  {{- $dbRootPass := .Values.nextcloudConfig.dbRootPass -}}
  {{- with (lookup "v1" "Secret" .Release.Namespace (printf "%s-mariadb-creds" $fullname)) -}}
    {{- $dbPass = ((index .data "MARIADB_PASSWORD") | b64dec) -}}
    {{- $dbRootPass = ((index .data "MARIADB_ROOT_PASSWORD") | b64dec) -}}
  {{- end }}

secret:
  mariadb-creds:
    enabled: true
    data:
      MARIADB_USER: {{ $dbUser }}
      MARIADB_DATABASE: {{ $dbName }}
      MARIADB_PASSWORD: {{ $dbPass }}
      MARIADB_ROOT_PASSWORD: {{ $dbRootPass }}
      MARIADB_HOST: {{ $dbHost }}
configmap:
  nextcloud-config:
    enabled: true
    data:
      PUID: {{ .Values.nextcloudConfig.ownerUID | quote }}
      PGID: {{ .Values.nextcloudConfig.ownerGID | quote }}
{{- end -}}
