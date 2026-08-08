# Hackthon-Project

> Infrastructure + Web UI demo for the Hackthon-Project (DevNetMohamed)

This repository contains infrastructure-as-code, web frontend assets, shell helpers, and Docker configuration used for a hackathon project. The codebase mixes Terraform (HCL) for provisioning, JavaScript/HTML/CSS for the UI, shell scripts for automation, and Dockerfile(s) for containerization.

## Table of contents

- [Project overview](#project-overview)
- [Key features](#key-features)
- [Tech stack](#tech-stack)
- [Prerequisites](#prerequisites)
- [Quick start](#quick-start)
  - [Local front-end (dev)](#local-front-end-dev)
  - [Build & run with Docker](#build--run-with-docker)
  - [Provision infrastructure (Terraform)](#provision-infrastructure-terraform)
- [Project layout](#project-layout)
- [Development notes](#development-notes)
- [Contributing](#contributing)
- [License](#license)

## Project overview

The Hackthon-Project demonstrates how to combine simple infrastructure provisioning with a lightweight web UI and containerized deployment. It is designed as a starting point for hackathon demos: deploy infrastructure with Terraform, run the web frontend in a container, and use shell helpers to automate common tasks.

> If you want the README customized with more specific details about the project's purpose (APIs used, cloud provider, or the demo workflow), tell me what the app does or link the main files and I’ll update it accordingly.

## Key features

- Terraform-based infrastructure definitions (HCL) for provisioning required resources
- Simple JavaScript + HTML frontend with CSS styles
- Shell scripts to simplify common developer tasks
- Dockerfile(s) for building and running the application in containers

## Tech stack

- HCL / Terraform
- JavaScript (vanilla or framework files present in the repo)
- HTML / CSS
- Shell scripts (automation / helpers)
- Docker

## Prerequisites

- Git
- Docker & Docker Compose (optional but recommended)
- Terraform (if you plan to provision infrastructure)
- Node.js & npm/yarn (if you want to run front-end tooling locally)

## Quick start

The repository contains multiple pieces; these steps assume a typical local developer workflow.

### Local front-end (dev)

1. Clone the repo:

   git clone https://github.com/DevNetMohamed/Hackthon-Project.git
   cd Hackthon-Project

2. Install dependencies (if the frontend has a package.json):

   npm install
   # or
   yarn install

3. Start a local dev server (adjust for your tooling):

   npm start
   # or serve the static files with a simple server, e.g.:
   npx http-server ./frontend -p 8080

Open http://localhost:8080 in your browser.

### Build & run with Docker

Build the Docker image (adjust tag and Dockerfile path if different):

   docker build -t hackthon-project:latest .
   docker run --rm -p 8080:80 hackthon-project:latest

If the repo includes a docker-compose.yml you can run:

   docker-compose up --build

### Provision infrastructure (Terraform)

If there is a `terraform/` or similar directory with HCL files:

1. Initialize Terraform inside that directory:

   cd terraform
   terraform init

2. Review the plan:

   terraform plan

3. Apply (make sure you understand what will be created):

   terraform apply

Use `terraform destroy` to tear down resources when finished.

## Project layout

Below is an example/likely layout based on repository composition. Adjust according to the actual repository structure.

- terraform/               # HCL files and modules
- frontend/                # HTML, JS, CSS web assets
- scripts/                 # Shell helper scripts
- Dockerfile               # Container image definition
- docker-compose.yml       # Optional compose setup
- README.md                # This file

## Development notes

- Keep secrets out of the repository. Use environment variables, a secrets manager, or Terraform variable files excluded from source control.
- Use `terraform fmt` and `terraform validate` to keep HCL clean.
- Add a `.env.example` file documenting required environment variables for local runs.
- If the frontend uses a bundler (webpack, rollup, vite), include build scripts in package.json.

## Contributing

Contributions are welcome. Suggested process:

1. Fork the repository
2. Create a feature branch: `git checkout -b feat/your-feature`
3. Make changes and add tests if applicable
4. Open a pull request describing your changes

Please follow conventional commit messages and keep changes scoped per PR.

## License

Add a LICENSE file to the repository if you want to define the project's license. If you prefer a default, consider the MIT License.

---

Maintained by DevNetMohamed
