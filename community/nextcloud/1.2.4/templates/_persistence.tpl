{{- define "nextcloud.persistence" -}}
persistence:
  data:
    enabled: true
    {{- include "ix.v1.common.app.storageOptions" (dict "storage" .Values.nextcloudStorage.data) | nindent 4 }}
    targetSelector:
      nextcloud:
        nextcloud:
          mountPath: /data
        {{- if and (eq .Values.nextcloudStorage.data.type "ixVolume")
                  (not (.Values.nextcloudStorage.data.ixVolumeConfig | default dict).aclEnable) }}
        01-permissions:
          mountPath: /mnt/directories/data
        {{- end }}
  config:
    enabled: true
    {{- include "ix.v1.common.app.storageOptions" (dict "storage" .Values.nextcloudStorage.config) | nindent 4 }}
    targetSelector:
      nextcloud:
        nextcloud:
          mountPath: /config
        {{- if and (eq .Values.nextcloudStorage.config.type "ixVolume")
                  (not (.Values.nextcloudStorage.config.ixVolumeConfig | default dict).aclEnable) }}
        01-permissions:
          mountPath: /mnt/directories/config
        {{- end }}
  {{- range $idx, $storage := .Values.nextcloudStorage.additionalStorages }}
  {{ printf "wp-%v" (int $idx) }}:
    enabled: true
    {{- include "ix.v1.common.app.storageOptions" (dict "storage" $storage) | nindent 4 }}
    targetSelector:
      nextcloud:
        nextcloud:
          mountPath: {{ $storage.mountPath }}
        {{- if and (eq $storage.type "ixVolume") (not ($storage.ixVolumeConfig | default dict).aclEnable) }}
        01-permissions:
          mountPath: /mnt/directories{{ $storage.mountPath }}
        {{- end }}
  {{- end }}
  tmp:
    enabled: true
    type: emptyDir
    targetSelector:
      nextcloud:
        nextcloud:
          mountPath: /tmp
  varrun:
    enabled: true
    type: emptyDir
    targetSelector:
      nextcloud:
        nextcloud:
          mountPath: /var/run
  mariadbdata:
    enabled: true
    {{- include "ix.v1.common.app.storageOptions" (dict "storage" .Values.nextcloudStorage.mariadbData) | nindent 4 }}
    targetSelector:
      # MariaDB pod
      mariadb:
        # MariaDB container
        mariadb:
          mountPath: /var/lib/mysql
        # MariaDB - Permissions container
        permissions:
          mountPath: /mnt/directories/mariadb_data
  mariadbbackup:
    enabled: true
    {{- include "ix.v1.common.app.storageOptions" (dict "storage" .Values.nextcloudStorage.mariadbBackup) | nindent 4 }}
    targetSelector:
      # MariaDB backup pod
      mariadbbackup:
        # MariaDB backup container
        mariadbbackup:
          mountPath: /mariadb_backup
        # MariaDB - Permissions container
        permissions:
          mountPath: /mnt/directories/mariadb_backup
{{- end -}}