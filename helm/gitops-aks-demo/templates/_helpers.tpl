{{/*
Expand the name of the chart.
*/}}
{{- define "gitops-aks-demo.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels.
*/}}
{{- define "gitops-aks-demo.labels" -}}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
app.kubernetes.io/name: {{ include "gitops-aks-demo.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels.
*/}}
{{- define "gitops-aks-demo.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gitops-aks-demo.fullname" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
