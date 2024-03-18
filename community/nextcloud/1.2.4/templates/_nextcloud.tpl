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
            PUID: .Values.nextcloudConfig.ownerUID
            PGID: .Values.nextcloudConfig.ownerGID
          {{ with .Values.nextcloudConfig.additionalEnvs }}
          envList:
            {{ range $env := . }}
            - name: {{ $env.name }}
              value: {{ $env.value }}
            {{ end }}
          {{ end }}
          probes:
            liveness:
              enabled: true
              type: http
              port: 80
              path: /status.php
            readiness:
              enabled: true
              type: http
              port: 80
              path: /status.php
            startup:
              enabled: true
              type: http
              port: 80
              path: /status.php
      initContainers:
      {{- include "ix.v1.common.app.permissions" (dict "containerName" "01-permissions"
                                                        "UID" .Values.nextcloudConfig.ownerUID
                                                        "GID" .Values.nextcloudConfig.ownerGID
                                                        "type" "install") | nindent 8 }}
      {{- include "ix.v1.common.app.mariadbWait" (dict "name" "mariadb-wait"
                                                       "secretName" "mariadb-creds") | nindent 8 }}
{{- end -}}
