# hello-platform

Serviço HTTP minimalista em Go usado como aplicação base nos labs de Platform Engineering (Azure + Kubernetes + CI/CD).

## Endpoints

| Rota | Resposta | Uso |
|---|---|---|
| `GET /` | `{"status":"ok","env":"dev"}` | Smoke test |
| `GET /health` | `200 OK` | Liveness/readiness probe |

## Rodar localmente

```bash
go run .
curl localhost:8080/health
curl localhost:8080/
```

## Docker

```bash
# Build
docker build -t hello-platform .

# Run (ambiente padrão: dev)
docker run -p 8080:8080 hello-platform

# Run com ambiente diferente
docker run -p 8080:8080 -e APP_ENV=staging hello-platform
docker run -p 8080:8080 -e APP_ENV=prod hello-platform
```

## Variáveis de ambiente

| Variável | Padrão | Valores |
|---|---|---|
| `APP_ENV` | `dev` | `dev`, `staging`, `prod` |

## Estrutura

```
hello-platform/
├── main.go        # servidor HTTP (stdlib only)
├── Dockerfile     # multi-stage: golang:1.24 → distroless/static
├── go.mod
└── .gitignore
```

## Docker image

- **Builder:** `golang:1.24` — compila o binário
- **Runtime:** `gcr.io/distroless/static-debian12` — sem shell, sem package manager (~10MB)
