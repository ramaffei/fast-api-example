<p style="text-align: center;">
  <a href="https://fastapi.tiangolo.com"><img src="https://fastapi.tiangolo.com/img/logo-margin/logo-teal.png" alt="FastAPI"></a>
</p>
<p style="text-align: center;">
    <em>Production ready Python Microservice for <a href="https://aws.amazon.com/es/lambda/">AWS Lambda</a> on <a href="https://fastapi.tiangolo.com">FastAPI</a></em>
</p>

---

**Documentation**: <a href="https://fastapi.tiangolo.com" target="_blank">https://fastapi.tiangolo.com</a>

**Source Code**: <a href="https://github.com/tiangolo/fastapi" target="_blank">https://github.com/tiangolo/fastapi</a>

---

## Running

### Requirements
- [Python 3.11.x](https://www.python.org/downloads/)
- [Docker](https://www.docker.com/) (Optional)
- [Docker Compose](https://docs.docker.com/compose/install/) (Optional)

Running the app using Docker (via `docker-compose`)  is recommended as it will automatically install all the dependencies, database and run the app.
Otherwise, you can run the app using VENV, but you will need to install the dependencies and database manually.

**_Note:_** Environment variables required for the app to run are located in the `.env.sample` file. Modify the file name to `.env` and fill in the values.

```shell
$ docker-compose build
$ docker-compose up app
```

<details>
<summary>Or using VENV</summary>

```bash
$ pip install -r requirements.txt -r app/requirements.txt
$ uvicorn --app-dir ./app main:app --reload
```
</details>

Then open the browser at the address: http://localhost:8000/docs

---

## Code Quality
This project provides a complete configuration for `pre-commit` using `ruff`, `flake8`, `isort` and `mypy`.
Between these tools, consistent quality code can be ensured.
This is validated in CI, and you can also run these checks in your local environment.

**Pre-commit and hook installation:**
```bash
pip install -r requirements.txt
wget -O .git/hooks/prepare-commit-msg https://raw.githubusercontent.com/commitizen-tools/commitizen/master/hooks/prepare-commit-msg.py
chmod +x .git/hooks/prepare-commit-msg
wget -O .git/hooks/post-commit https://raw.githubusercontent.com/commitizen-tools/commitizen/master/hooks/post-commit.py
chmod +x .git/hooks/post-commit
pre-commit install
```

To run checks manually:

```bash
pre-commit  # for staged changes
pre-commit run --all-files  # for all files
```

---

## DB Migrations
This project uses [Alembic](https://alembic.sqlalchemy.org/en/latest/) for database migrations.

To start up the database run the command:
```bash
$ docker-compose up db
```

And then to create and migrate the database, run the command:

```bash
$ docker-compose run migrations
```

<details>
<summary>Or using VENV</summary>

```bash
$ alembic upgrade head
```
</details>

---

## Debugging

Setting Up Debugger for Visual Studio Code with Docker

1. Create a .vscode Folder:
   - Open your project directory in Visual Studio Code
   - Create a new folder named `.vscode` in the root of your project

2. Create launch.json File:
   - Inside the `.vscode` folder, create a new file named `launch.json`

3. Copy Contents from ._vscode/launch.json:
   - Open the `.vscode/launch.json` file, and configure it with the appropriate settings for your project. This file is used to define configurations for launching and debugging your application

4. Run the Docker Container:
   - Open a terminal.
   - Navigate to your project directory.
   - Execute the following command to start the Docker container service:

     ```bash
     $ docker-compose up app
     ```

5. Start Debugging:
   - Set breakpoints in your code where you want to start debugging
   - Press `F5` in Visual Studio Code to start the debugging process

6. Debug Your Application:
    - Once connected, you can use the debugging features in Visual Studio Code to step through your code, inspect variables, and troubleshoot issues

---

## Testing
This project has configuration for `pytest` and `coverage` to ensure that the code is tested and has coverage.

To run the tests use the command:
```bash
$ docker-compose run tests
```

<details>
<summary>Or using VENV</summary>

```bash
$ pip install -r tests/requirements.txt
$ pytest tests
```
</details>

---

## Architecture
<p style="text-align: center;"><img src="doc/MSDiagram.gif" alt="AWS Architecture"/></p>

### SQS Trigger example
<p style="text-align: center;"><img src="doc/SQSExample.gif" alt="SQS Trigger Example"/></p>

---

## Branching strategy
Every new branch has to follow the following naming convention (lowercase): `{branch_type}/{issue_number}_{description}`

Where `branch_type` can be `feature`, `bugfix` or `hotfix`.

Example: `feature/DASHBOARD-1234_add_new_feature`

### Main branches
- `DEV`: Main branch for development
- `STG`: Main branch for staging
- `UAT`: Main branch for user acceptance testing
- `PRD`: Main branch for production

### PR strategy
Depending on the branch type, the PR has to be done to the following branch.

**Feature**:

1. Branch DEV -> PR to DEV -> Deploy to DEV
2. DEV OK? -> PR to STG -> Deploy STG -> Testing QA
3. STG OK? -> PR to UAT -> Deploy UAT -> Final revision and integrations tests
4. UAT OK? -> PR to PRD -> Deploy PRD

**Bugfix**:

1. Branch UAT -> PR to UAT -> Deploy to UAT
2. UAT OK? -> PR to PRD -> Deploy PRD

_Note_: Bugfix can be done to DEV as well.

**Hotfix**:

1. Branch PRD -> PR to PRD -> Deploy to PRD

_Note_: Hotfix can be done to UAT as well.
