# DockerShield

## 📌 Sobre o Projeto

DockerShield é um projeto para containerizar uma aplicação React e escaneá-la quanto a vulnerabilidades usando **Trivy**. Ele também gera relatórios detalhados sobre a segurança da imagem Docker criada.

---

## 🛠️ Requisitos
Antes de iniciar, certifique-se de ter os seguintes programas instalados:

- [Docker](https://docs.docker.com/get-docker/)
- [Trivy](https://aquasecurity.github.io/trivy/v0.45.1/getting-started/installation/)
- [Make](https://www.gnu.org/software/make/)
- [Git](https://git-scm.com/)

---

## 📥 Instalação

Clone este repositório:
```bash
# Usando GitHub CLI
gh repo clone gabrielldn/DockerShield

# Ou usando Git
git clone https://github.com/gabrielldn/DockerShield.git
```
Entre no diretório do projeto:
```bash
cd DockerShield
```

---

## 🚀 Como Usar

### 🔹 1. Construir a imagem Docker
Use o comando abaixo para construir a imagem:
```bash
make build
```
Por padrão, a imagem será criada com o nome **docker-shield**.

### 🔹 2. Escanear a imagem
Caso queira construir e escanear a imagem de uma só vez, execute:
```bash
make all
```

O script **build-and-scan.sh** pedirá o nome e a tag da imagem. Se vulnerabilidades forem encontradas, a imagem será automaticamente removida.

---

## 📊 Relatórios de Segurança

- Os relatórios gerados pelo **Trivy** são armazenados na pasta `relatory/`.
- O arquivo **trivy_report.json** contém os detalhes das vulnerabilidades encontradas.
- O arquivo **SecIssues.md** apresenta um resumo das vulnerabilidades organizadas por severidade.

---

## 🛑 Remoção de Imagens Inseguras
Caso vulnerabilidades sejam detectadas, a imagem será **automaticamente removida** para evitar uso indevido.

---

## 📝 Licença
Este projeto está sob a licença **MIT**. Sinta-se à vontade para usá-lo e modificá-lo!

---

## 👨‍💻 Autor
Desenvolvido por **Gabriel Lopes (gabrielldn)**.

---

🚀 **Aproveite o DockerShield e mantenha suas imagens seguras!**