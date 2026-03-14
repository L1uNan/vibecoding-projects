default:
    @just --list

setup:
    uv sync

init package profile="simple":
    @if [ "{{profile}}" != "simple" ] && [ "{{profile}}" != "domain" ]; then \
        echo "profile must be 'simple' or 'domain'"; \
        exit 1; \
    fi
    cp ".importlinter.{{profile}}" .importlinter
    perl -pi -e "s/<pkg>/{{package}}/g" pyproject.toml Justfile .importlinter

dev:
    uv run uvicorn <pkg>.api.main:app --reload --host 0.0.0.0 --port 8000

dod:
    just format
    just lint
    just typecheck
    just test
    just check-deps

format:
    uv run ruff format .

lint:
    uv run ruff check . --fix
    uv run ruff check .

typecheck:
    uv run mypy

test:
    uv run pytest -q

test-cov:
    uv run pytest --cov=src --cov-fail-under=80

test-local-db:
    TEST_DATABASE_URL=sqlite+aiosqlite:///:memory: uv run pytest -q -m integration

db-up:
    uv run alembic upgrade head

db-down:
    uv run alembic downgrade -1

check-deps:
    @if [ ! -f .importlinter ]; then \
        echo "缺少 .importlinter，请先执行：just init <pkg> [simple|domain]"; \
        exit 1; \
    fi
    uv run lint-imports

contract:
    uv run schemathesis run openapi/openapi.yaml --url http://127.0.0.1:8000

contract-asgi:
    uv run schemathesis run openapi/openapi.yaml --app <pkg>.api.main:app
