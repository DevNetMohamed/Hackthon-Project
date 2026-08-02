# AWS Docker Lab – Application Containerization and Docker Hub CI/CD

A simple HTML, CSS, and JavaScript web application served by Node.js and containerized with Docker.

The application displays:

- Student name: **Yousef Ismail Ahmed**
- The current date
- The text **AWS Docker Lab**

## Project Structure

```text
aws-docker-lab-part3/
├── .github/
│   └── workflows/
│       └── docker-ci.yml
├── public/
│   ├── index.html
│   ├── script.js
│   └── styles.css
├── .dockerignore
├── Dockerfile
├── package.json
├── README.md
└── server.js
```

## Part 3 – Run Locally

```bash
npm start
```

Open:

```text
http://localhost:3000
```

Health endpoint:

```text
http://localhost:3000/api/health
```

## Part 3 – Build and Run with Docker

Start Docker Desktop first, then run:

```bash
docker build -t aws-docker-lab:1.0 .
docker run -d --name aws-docker-container -p 3000:3000 aws-docker-lab:1.0
```

Open:

```text
http://localhost:3000
```

Verify:

```bash
docker images
docker ps
curl http://localhost:3000/api/health
```

## Part 5 – GitHub Actions and Docker Hub

Workflow file:

```text
.github/workflows/docker-ci.yml
```

### Workflow Behaviour

On **every push**, the workflow:

1. Checks out the repository.
2. Configures Docker Buildx.
3. Builds the Docker image.
4. Loads and verifies the image.

When the push is made to the **main** branch and the Docker Hub secrets are configured, it also:

5. Logs in to Docker Hub.
6. Tags the image using `latest` and the Git commit SHA.
7. Pushes both image tags to Docker Hub.

Published image names:

```text
DOCKERHUB_USERNAME/aws-docker-lab:latest
DOCKERHUB_USERNAME/aws-docker-lab:GITHUB_COMMIT_SHA
```

If the secrets are not configured, the Docker image is still built and verified; only the optional publishing steps are skipped.

## Create the Docker Hub Repository

In Docker Hub, create a public repository named:

```text
aws-docker-lab
```

The repository name must match the `IMAGE_NAME` value in the workflow.

## Required GitHub Secrets

Open the GitHub repository:

```text
Settings → Secrets and variables → Actions → New repository secret
```

Add:

| Secret name | Value |
|---|---|
| `DOCKERHUB_USERNAME` | Your Docker Hub username |
| `DOCKERHUB_TOKEN` | A Docker Hub personal access token |

Use an access token instead of your Docker Hub password. Never place credentials directly in the workflow, source code, README, commits, screenshots, or Docker image.

## Push the Project to GitHub

```bash
git init
git add .
git commit -m "Add Docker Hub CI/CD workflow"
git branch -M main
git remote add origin https://github.com/YOUR_GITHUB_USERNAME/YOUR_REPOSITORY.git
git push -u origin main
```

Then open:

```text
GitHub Repository → Actions → Docker CI/CD to Docker Hub
```

## Pull and Run the Image from Docker Hub

Replace `YOUR_DOCKERHUB_USERNAME` with your username:

```bash
docker pull YOUR_DOCKERHUB_USERNAME/aws-docker-lab:latest

docker run -d \
  --name aws-docker-container \
  -p 3000:3000 \
  YOUR_DOCKERHUB_USERNAME/aws-docker-lab:latest
```

Open:

```text
http://localhost:3000
```

## Cleanup

```bash
docker stop aws-docker-container
docker rm aws-docker-container
docker rmi YOUR_DOCKERHUB_USERNAME/aws-docker-lab:latest
```

## Security Note

Rotate any AWS access key or password that was shared in a chat, message, screenshot, or document. The Docker Hub workflow does not require AWS credentials, so remove the old AWS secrets from the GitHub repository if they were added.
