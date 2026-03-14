# Python 项目规范

> 项目目标：用**最少的约定**换取**稳定的质量门禁**与**一致的可维护性**。

## 1. 技术栈与门禁
- 语言：Python（建议 3.11+；新项目优先 3.12+）
- Web：FastAPI + Uvicorn
- 依赖与命令入口：`uv`
- ORM / 数据访问：SQLAlchemy 2.x（Async）
- 数据库迁移：Alembic
- 本地测试数据库：SQLite（`aiosqlite`，默认无 Docker）
- 可选生产数据库：PostgreSQL（`asyncpg`，用于生产/专项集成测试）
- 格式化 / Lint：`ruff`（以 `ruff format` / `ruff check` 为准）
- 类型检查：`mypy`
- 测试：`pytest`

### 1.1 OpenSpec 工作流（必需）
API 与功能变更必须走 OpenSpec 文件流，不允许“先写代码再补文档”。

- 配置入口：`openspec/config.yaml`、`openspec/schemas/hybrid-workflow/schema.yaml`
- 激活变更：`openspec/.active`（内容为当前 `<change-name>`）
- 变更目录：`openspec/changes/<change-name>/`
- 必备追踪文件：`task_plan.md`、`findings.md`、`progress.md`

最小流程：
1. 建立/切换 `openspec/changes/<change-name>/` 并设置 `openspec/.active`
2. 完成 `proposal.md -> design.md -> specs/*.md -> tasks.md`
3. 再进入实现与验证

## 2. 推荐目录结构
推荐使用 `src/` 布局，避免“工作目录导入”导致的隐式依赖。

```
.
├── pyproject.toml
├── Justfile                 # 团队统一命令入口（推荐）
├── openapi/
│   └── openapi.yaml         # Design-First 的 API 规范
├── openspec/
│   ├── .active
│   ├── config.yaml
│   └── changes/
├── alembic/                 # （可选）数据库迁移脚本
├── alembic.ini              # （可选）Alembic 配置
├── src/
│   └── <pkg>/
│       ├── api/
│       │   ├── main.py          # FastAPI app 创建与路由挂载
│       │   ├── routers/         # APIRouter 按域拆分
│       │   ├── schemas/         # Pydantic 请求/响应模型（DTO）
│       │   ├── deps.py          # Depends 依赖（鉴权/会话/配置）
│       │   └── middleware.py    # 中间件（request id / tracing / logging）
│       ├── domain/              # （可选）领域对象（实体/值对象）
│       │   ├── entities.py
│       │   └── value_objects.py
│       ├── services/            # 用例/业务编排（尽量不耦合 FastAPI）
│       ├── integrations/        # DB / HTTP client / 外部系统适配
│       │   ├── persistence/
│       │   │   ├── repositories/
│       │   │   └── models/
│       │   └── clients/
│       └── core/
│           ├── settings.py      # 配置（pydantic-settings）
│           ├── logging.py       # logging 统一配置
│           └── errors.py        # 领域错误与 API 错误映射
└── tests/
    ├── unit/
    ├── integration/
    ├── contract/
    └── stubs/
```

约定：
- `api/` 只做“HTTP 相关”的薄层：参数解析、校验、依赖注入、错误转换、返回模型。
- `services/` 放可测试的业务逻辑与用例编排；优先让它们可脱离 FastAPI 运行。
- `integrations/` 统一放外部依赖（数据库/第三方 HTTP/消息队列），便于替身与隔离测试。

### 2.1 依赖方向约束（强约束）
目录是建议，依赖方向是强约束。统一使用 `A -> B` 表示 “A import B”。

默认导入方向（import）：

- `api -> services`
- `api.deps -> integrations`（组合根，负责注入具体实现）
- `services -> core`
- `services -> domain`（启用 `domain` 时）
- `integrations -> services`（仅依赖仓储/网关 `Protocol`）
- `integrations -> domain`（启用 `domain` 时）
- `domain` 不依赖 `core/services/api/integrations`
- `core` 不依赖 `domain/services/api/integrations`

默认调用链（runtime）：

`api` 调用 `services`；`services` 通过仓储/网关协议访问外部能力；具体实现由 `api/deps.py` 注入为 `integrations` 实现。

强约束规则：
- `core` 不能依赖 `domain/services/api/integrations`
- `domain`（若启用）不能依赖 `services/api/integrations/core`
- `services` 不能依赖 `api`，且不能依赖 `integrations` 的具体实现
- `integrations` 不能依赖 `api`，可依赖 `services/domain` 中定义的协议与业务对象
- `api` 仅允许在 `deps.py` 依赖 `integrations` 进行组装（composition root），其他 `api` 模块禁止依赖 `integrations`

工具门禁：
- 使用 `import-linter` + `.importlinter` 在 CI/本地强制检查依赖方向。
- 提供两套模板：`.importlinter.simple`（不启用 `domain`）与 `.importlinter.domain`（启用 `domain`）。

### 2.2 Repository Pattern（推荐）
目标：`services` 不绑定 ORM/HTTP SDK 的具体实现。

- 在 `services`（或 `domain`）定义协议（`Protocol`），例如 `OrderRepository`。
- 在 `integrations/persistence/repositories` 提供实现（如 SQLAlchemy 版本）。
- 在 `api/deps.py` 里完成实现注入，`services` 仅依赖协议。

示例：

```python
class OrderRepository(Protocol):
    async def get(self, order_id: str) -> Order: ...
```

### 2.3 `domain` 层（可选）
复杂业务（规则多、对象生命周期长）建议启用 `domain/`，承载实体和值对象。

- 简单 CRUD 项目可先不拆 `domain`，后续演进再抽离。
- 无论是否拆 `domain`，都要保证“ORM model 不污染业务对象”。

## 3. 标准命令（just）
统一命令入口为 `just`；`Justfile` 内部再调用 `uv run ...`。
- `just` 为优先入口。
- 若环境缺少 `just`，使用等效 `uv run ...` 命令执行。
- 不得因缺少 `just` 阻塞任务。

- 安装/同步依赖：`just setup`
- 启动开发服务：`just dev`
- 格式化：`just format`
- Lint（含自动修复）：`just lint`
- 类型检查：`just typecheck`
- 测试：`just test`
- 覆盖率门禁（可选）：`just test-cov`
- 本地数据库集成测试：`just test-local-db`
- 迁移升级：`just db-up`
- 回滚一步迁移：`just db-down`
- 依赖方向检查：`just check-deps`
- 提供方契约测试（URL 模式，需要服务已启动）：`just contract`
- 提供方契约测试（ASGI 直连，不需要先启动服务）：`just contract-asgi`
- 一键 DoD：`just dod`
- 模板初始化：`just init <pkg> [simple|domain]`

### 3.1 Justfile（推荐）
团队执行建议统一为 `just`，避免每人记忆不同命令组合与脚本漂移。

最小目标建议：
- `setup`、`init`、`dev`、`format`、`lint`、`typecheck`、`test`、`test-cov`、`test-local-db`、`db-up`、`db-down`、`check-deps`、`contract`、`contract-asgi`、`dod`
- `dod = format + lint + typecheck + test + check-deps`

### 3.2 模板初始化
模板首次使用必须先替换 `<pkg>` 占位符并选择依赖约束模板：

- `just init my_fastapi_app simple`：不启用 `domain` 的项目
- `just init my_fastapi_app domain`：启用 `domain` 的项目

初始化会更新：`pyproject.toml`、`Justfile`、`.importlinter`。
- `.importlinter` 是初始化生成产物；仓库只维护模板：`.importlinter.simple`、`.importlinter.domain`。
- `just check-deps` 依赖 `.importlinter`，因此必须先执行 `just init ...`。

## 4. 编码规范（Pythonic 优先）
### 4.1 可读性与边界
- “显式优于隐式”：宁可多写两行，也不要让读者猜测副作用与数据形态。
- 业务逻辑优先写成**纯函数/小对象**，避免把逻辑塞进路由/依赖里。

### 4.2 类型（mypy 门禁）
- 对外边界（API schema、服务入口、集成适配器）必须写类型标注。
- 所有对外接口（`router` / `service` / `integration`）必须完整类型标注（参数、返回值、关键成员）。
- 公共函数、类与模块级公共方法应使用 Google-style docstring，描述用途、参数、返回值与异常。
- 优先使用 `collections.abc` 与 `typing` 中的具体类型（如 `Mapping[str, str]`、`Sequence[T]`）。
- 谨慎使用 `Any`：出现 `Any` 要说明原因（例如第三方库缺少 stubs）并尽量把 `Any` 隔离在边界层。
- 需要“可替换实现”时，优先用 `Protocol` 表达能力边界，而不是强制引入抽象基类层级。
- `src/` 布局下建议用配置驱动 mypy（避免命令行传参导致的包解析差异），最低配置示例：

```toml
[tool.mypy]
mypy_path = ["src"]
files = ["src/<pkg>"]
```

### 4.3 异常与错误处理
- 禁止裸 `except:`；捕获要具体、处理要明确（记录日志、转换错误、或继续抛出）。
- `services/` 内部优先抛出**领域错误**（自定义异常），在 `api/` 统一映射为 HTTP 错误。

#### API 错误格式（项目级约定）
每个项目在初始化时选择一种错误格式，并在 `core/errors.py` 记录与全局遵守（通过 FastAPI 全局 exception handler 统一转换）。

- 选项 A：RFC 9457（Problem Details）
  - 字段：`type`, `title`, `status`, `detail`, `instance`（按需扩展 `errors` 等字段）
- 选项 B：简化错误格式（内部服务常用）
  - 字段：`code`, `message`, `detail`（可选），并确保所有 API 返回一致结构

### 4.4 日志
- 禁止 `print`；使用 `logging`。
- 日志要可检索：包含关键维度（如 `request_id`、用户/租户、关键资源 id）。
- 重要流程可选接入 OpenTelemetry tracing（先约定 span 命名，再谈全面铺开）。
- 关键业务路径必须落结构化日志并补 trace span，确保问题可定位、链路可追踪。

### 4.5 Async / 性能
- I/O 路径优先 `async`：HTTP、DB、文件读写要避免阻塞事件循环。
- 必须调用阻塞库时：放入线程池/使用异步替代库，并在代码评审中明确说明。

## 5. FastAPI 约定
- 路由组织：按业务域拆分 `APIRouter`；统一挂载到 `api/main.py`。
- 版本化：对外 API 建议 `/api/v1` 前缀（避免后续破坏性升级）。
- 请求/响应模型：必须用 Pydantic 模型；避免“随手返回 dict”导致契约漂移。
- 依赖注入：鉴权、数据库会话、配置读取统一放 `deps.py`，并支持测试覆盖（dependency override）。
- 启动/关闭：使用 lifespan 管理连接池、客户端初始化与释放（避免散落在全局变量）。
- 健康检查：提供 `/health`（liveness）与 `/ready`（readiness）端点，并放在独立 router（例如 `api/routers/health.py`）。

### 5.1 API Design-First（OpenSpec）
所有新增/变更 API 默认先设计后实现：

1. 在 OpenSpec change 中先完成 `proposal.md -> design.md -> specs/*.md -> tasks.md`
2. 先更新 OpenAPI 规范（建议放 `openapi/openapi.yaml`），再写 FastAPI 路由与实现
3. 合并前校验”规范与实现一致”：路由、模型、状态码、错误模型一致

### 5.2 安全约定（最小集）
- 鉴权必须通过 `deps.py` 暴露为依赖（例如 `Depends(get_current_user)`），不要在业务函数里到处解析 token/header。
- 生产环境禁止向客户端返回内部异常堆栈；详细错误只记录到日志（并脱敏）。
- CORS 默认关闭或最小放行；禁止 `allow_origins=["*"]` 与携带凭证同时开启。
- 任何密钥/令牌只来自环境变量与安全存储，不写入仓库与镜像。
- 上线前对照 OWASP API Security Top 10 做一次自查（鉴权、鉴权绕过、注入、限流、日志脱敏等）。

## 6. 测试策略（pytest）
目标是“快速反馈 + 清晰边界”，不是为了数字堆覆盖率。

- `tests/unit/`：核心逻辑单元测试，快且稳定。
- `tests/integration/`：框架/数据库/依赖注入整合验证。
- `tests/contract/`：API 契约与第三方交互契约测试。

分层测试矩阵：
- `core`：纯单元测试，不依赖 FastAPI/DB/网络。
- `services`：单元测试为主；涉及事务或框架行为时补少量集成测试。
- `api`：路由集成测试（TestClient/HTTPX）+ 提供方契约测试（Schemathesis）。
- `integrations.persistence`：迁移后集成测试（仓储/查询/事务行为）。
- `integrations.client`：外部调用隔离测试（`respx`/`responses`），禁止直连真实三方服务。
- 应用组装（启动层）：至少一个启动冒烟测试（lifespan、配置加载、路由注册）。

三方系统隔离测试约定：
- `httpx` 客户端优先用 `respx`；`requests` 客户端用 `responses`。
- stub 数据集中放在 `tests/stubs/`，避免散落在测试函数中。
- 外部契约变更时，先更新 OpenAPI/契约样例，再更新 `integrations` 测试。

建议设置覆盖率底线（例如 80%）作为门禁，避免测试持续退化。

### 6.1 Docker 与数据库默认策略
- 默认策略：测试流程不依赖 Docker，单元测试与大部分集成测试使用内存数据库（优先 SQLite in-memory）或轻量本地实例。
- 默认原则：开发机与 CI 在无 Docker 环境也必须可运行 `just dod`。
- 升级策略：仅在需要验证真实数据库方言/索引/锁行为时，启用容器化数据库做专项集成测试。
- 迁移要求：无论使用内存库还是容器库，数据库 schema 统一由 Alembic 迁移管理，不允许手工漂移。
- 推荐测试连接串：`sqlite+aiosqlite:///:memory:`（单测/快速集成测试），PostgreSQL 仅用于专项验证。

## 7. 配置与环境
- 采用 12-factor 思路：配置来自环境变量与 `.env`（本地），不要把密钥写进代码库。
- 建议使用 `pydantic-settings` 定义 `Settings`，并在 app 启动时加载一次、依赖注入传递。
- 如启用数据库：迁移脚本使用 Alembic，迁移执行与应用启动解耦（部署流程负责跑迁移）。
- 数据库配置建议分层：`DB_MODE=memory`（默认）/`DB_MODE=container`（专项测试）；默认值必须是 `memory`，保证无 Docker 可跑。
- 建议区分：`DATABASE_URL`（运行时）与 `TEST_DATABASE_URL`（测试时）；测试默认指向 SQLite。

## 8. Definition of Done（DoD）
提交/合并前必须满足：
1. `just format`
2. `just lint`
3. `just typecheck`（类型门禁通过）
4. `just test`（相关测试通过）
5. `just check-deps`（依赖方向门禁通过）
6. 如项目启用覆盖率门禁：`just test-cov`
7. 如项目启用 Design-First（存在 OpenAPI spec）：运行 `just contract-asgi`（或先启动服务后运行 `just contract`）
8. 如果引入新行为：补测试；如果改变对外契约：同步更新 OpenAPI/OpenSpec 文档
9. 功能变更需同步更新 `README.md` 与相关 `docs/*`；如项目维护变更日志，需同步更新 `CHANGELOG.md`

### 8.1 pre-commit（推荐）
建议把门禁自动化到提交阶段（避免仅靠人工执行）。
- 首次启用前先执行 `just init <pkg> [simple|domain]`，确保 `.importlinter` 已生成。

- 安装并启用：`uv run pre-commit install`
- 全量检查：`uv run pre-commit run -a`

配置文件：`.pre-commit-config.yaml`（建议 ruff 用官方 hook；mypy 用本地 hook 走 `uv run mypy`，保证依赖与 typeshed 与项目一致）。

模板项目可直接使用本仓库提供的：`Justfile`、`.pre-commit-config.yaml`、`pyproject.toml`、`.importlinter.simple`、`.importlinter.domain`。

## 9. 评审清单（PR Checklist）
- 路由是否“薄”？业务逻辑是否在 `services/` 可测？
- 是否引入不必要的抽象/分层？
- 是否新增了 `Any` / 动态 dict 传播？能否隔离在边界？
- 错误是否统一映射？日志是否包含关键维度？
- 如涉及对外契约，OpenSpec 变更目录与 `openapi/openapi.yaml` 是否同步更新？
- 如项目启用 Design-First，`just contract-asgi`（或 `just contract`）是否通过？
- 新增 `integrations` 实现是否有对应 `Protocol`，并通过 `api/deps.py` 注入？
- `ruff/mypy/pytest/import-linter` 是否全部通过？

## 10. Git 工作流约定
- 分支命名：`feat/<topic>`、`fix/<topic>`、`chore/<topic>`。
- 提交信息：采用 Conventional Commits（如 `feat(api): add order query endpoint`）。
- 合并策略：默认 rebase 保持线性历史；主分支合并使用 squash merge。
- 每个功能变更必须关联一个 OpenSpec change 目录，并在合并前完成追踪文件更新。

## 11. 架构可视化与文档
- 维护 `docs/architecture.md`（Mermaid）展示模块边界与依赖方向。
- 涉及依赖方向、边界职责、数据流变化时，必须同步更新架构图。
- 重大架构决策记录到 `docs/adr/`（一个决策一个 ADR）。
