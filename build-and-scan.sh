#!/bin/bash
set -e

# Solicita o nome da imagem (input obrigatório)
read -p "Digite o nome da imagem (obrigatório): " imageName
if [[ -z "$imageName" ]]; then
  echo "Nome da imagem é obrigatório. Saindo..."
  exit 1
fi

# Solicita a tag da imagem (input opcional, default: latest)
read -p "Digite a tag da imagem (padrão: latest): " imageTag
if [[ -z "$imageTag" ]]; then
  imageTag="latest"
fi

fullImage="${imageName}:${imageTag}"

echo "📦 Construindo a imagem Docker: ${fullImage}..."
docker build -t "${fullImage}" .

# Cria a pasta 'relatory' se não existir
mkdir -p relatory

echo "🔍 Executando o escaneamento com Trivy..."
trivy image --format json -o relatory/trivy_report.json "${fullImage}"

# Conta o total de vulnerabilidades encontradas
vuln_count=$(jq '[.Results[].Vulnerabilities[]?] | length' relatory/trivy_report.json 2>/dev/null || echo "0")

if [ "$vuln_count" -gt 0 ]; then
    echo "⚠️ Vulnerabilidades encontradas! Total: $vuln_count"
else
    echo "✅ Nenhuma vulnerabilidade encontrada."
fi

echo "📄 Gerando relatório de issues em relatory/SecIssues.md..."
jq -r '
  def severity_val:
    if .Severity == "HIGH" then 0
    elif .Severity == "MEDIUM" then 1
    elif .Severity == "LOW" then 2
    else 3 end;
  (
    "| Vulnerability ID | Package | Severity | Title | Link |",
    "| --- | --- | --- | --- | --- |",
    ([ .Results[] | .Vulnerabilities[]? ]
      | sort_by(severity_val)
      | map("| " + ([.VulnerabilityID, .PkgName, .Severity, .Title, (.PrimaryURL // "N/A")] | join(" | ")) + " |")
      | .[] )
  )
' relatory/trivy_report.json > relatory/SecIssues.md

if [ "$vuln_count" -gt 0 ]; then
    echo "❌ Removendo a imagem ${fullImage} para prevenir seu uso..."
    docker rmi "${fullImage}"
    exit 1
fi

echo "✅ Build e scan concluídos com sucesso! Nenhuma vulnerabilidade crítica encontrada."
