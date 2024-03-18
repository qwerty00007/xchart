{{- define "nextcloud.workload" -}}
workload:
  nextcloud:
    enabled: true
    primary: true
    type: Deployment
    podSpec:
      hostNetwork: false
      containers:
        nextcloud:
          enabled: true
          primary: true
          imageSelector: image
          securityContext:
            runAsUser: 0
            runAsGroup: 0
            runAsNonRoot: false
            readOnlyRootFilesystem: false
            capabilities:
              add:
                - CHOWN
                - DAC_OVERRIDE
                - FOWNER
                - SETGID
                - SETUID
          fixedEnv:
            PUID: 1000
            PGID: 1000
          {{ with .Values.nextcloudConfig.additionalEnvs }}
          envList:
            {{ range $env := . }}
            - name: {{ $env.name }}
              value: {{ $env.value }}
            {{ end }}
          {{ end }}
          probes:
            liveness:
              enabled: false
            readiness:
              enabled: false
            startup:
              enabled: false
      initContainers:
      {{- include "ix.v1.common.app.permissions" (dict "containerName" "01-permissions"
                                                        "UID" .Values.nextcloudConfig.ownerUID
                                                        "GID" .Values.nextcloudConfig.ownerGID
                                                        "type" "install") | nindent 8 }}
      {{- include "ix.v1.common.app.mariadbWait" (dict "name" "mariadb-wait"
                                                       "secretName" "mariadb-creds") | nindent 8 }}
{{- end -}}
