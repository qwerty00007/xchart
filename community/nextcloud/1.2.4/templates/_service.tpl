{{- define "nextcloud.service" -}}
service:
  nextcloud:
    enabled: true
    primary: true
    type: NodePort
    targetSelector: nextcloud
    ports:
      webui:
        enabled: true
        primary: true
        port: {{ .Values.nextcloudNetwork.webPort }}
        nodePort: {{ .Values.nextcloudNetwork.webPort }}
        targetPort: 80
        targetSelector: nextcloud
  mariadb:
    enabled: true
    type: ClusterIP
    targetSelector: mariadb
    ports:
      mariadb:
        enabled: true
        primary: true
        port: 3306
        targetPort: 3306
        targetSelector: mariadb
{{- end -}}
