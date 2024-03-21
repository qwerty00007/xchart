{{/*
Formats volumeMount for Lucky tls keys and trusted certs
*/}}
{{- define "lucky.tlsKeysVolumeMount" -}}
{{- if eq (include "cert_helper.certAvailable" .) "true" -}}
- name: cert-secret-volume
  mountPath: "/etc/lucky/certs"
- name: trusted-cert-secret-volume
  mountPath: "/etc/lucky/certs/CAs"
{{- end }}
{{- end -}}

{{/*
Formats volume for Lucky tls keys and trusted certs
*/}}
{{- define "lucky.tlsKeysVolume" -}}
{{- if eq (include "cert_helper.certAvailable" .) "true" -}}
- name: cert-secret-volume
  secret:
    secretName: {{ include "cert_helper.secretName" . }}
    items:
    - key: certPublicKey
      path: public.crt
    - key: certPrivateKey
      path: private.key
- name: trusted-cert-secret-volume
  secret:
    secretName: {{ include "cert_helper.secretName" . }}
    items:
    - key: certPublicKey
      path: public.crt
{{- end }}
{{- end -}}