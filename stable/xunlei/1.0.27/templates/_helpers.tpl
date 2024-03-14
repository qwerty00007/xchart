{{/*
Determine secret name.
*/}}
{{- define "cert_helper.secretName" -}}
{{- include "common.names.fullname" . -}}
{{- end -}}


{{/*
Retrieve true/false if cert_helper certificate is configured
*/}}
{{- define "cert_helper.certAvailable" -}}
{{- if .Values.certificate -}}
{{- $values := (. | mustDeepCopy) -}}
{{- $_ := set $values "commonCertOptions" (dict "certKeyName" $values.Values.certificate) -}}
{{- template "common.resources.cert_present" $values -}}
{{- else -}}
{{- false -}}
{{- end -}}
{{- end -}}


{{/*
Retrieve public key of cert_helper certificate
*/}}
{{- define "cert_helper.cert.publicKey" -}}
{{- $values := (. | mustDeepCopy) -}}
{{- $_ := set $values "commonCertOptions" (dict "certKeyName" $values.Values.certificate "publicKey" true) -}}
{{ include "common.resources.cert" $values }}
{{- end -}}


{{/*
Retrieve private key of cert_helper certificate
*/}}
{{- define "cert_helper.cert.privateKey" -}}
{{- $values := (. | mustDeepCopy) -}}
{{- $_ := set $values "commonCertOptions" (dict "certKeyName" $values.Values.certificate) -}}
{{ include "common.resources.cert" $values }}
{{- end -}}

{{/*
返回端口号
*/}}
{{- define "port_helper.port" -}}
{{- if not .Values.hostNetwork -}}
{{- .Values.xunleiServerHttp.port -}}
{{- else -}}
{{- 2345 -}}
{{- end -}}
{{- end -}}