{{- define "librebooking.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{- define "librebooking.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end }}

{{- define "librebooking.labels" -}}
app.kubernetes.io/name: {{ include "librebooking.name" . }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "librebooking.selectorLabels" -}}
app.kubernetes.io/name: {{ include "librebooking.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Nil-safe service account name helper */}}
{{- define "librebooking.serviceAccountName" -}}
{{- $sa := default (dict) .Values.serviceAccount -}}
{{- $create := default false $sa.create -}}
{{- if $create -}}
{{- default (printf "%s-sa" (include "librebooking.fullname" .)) $sa.name -}}
{{- else -}}
{{- default "default" $sa.name -}}
{{- end -}}
{{- end -}}
