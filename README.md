# repo_name



Project contact: [first.last@ukhsa.gov.uk](mailto:first.last@ukhsa.gov.uk)

[![pre-commit](https://github.com/ukhsa-internal/ukhsa-project-template/actions/workflows/pre-commit.yml/badge.svg)](https://github.com/ukhsa-internal/ukhsa-project-template/actions/workflows/pre-commit.yml)
[![Ruff](https://img.shields.io/endpoint?url=https://raw.githubusercontent.com/astral-sh/ruff/main/assets/badge/v2.json)](https://github.com/astral-sh/ruff)

## PURPOSE
*include a purpose for your repository*

---

## About

This repo is a [GitHub template](https://docs.github.com/en/repositories/creating-and-managing-repositories/creating-a-template-repository#about-template-repositories) repo, created from the [cookiecutter](https://cookiecutter.readthedocs.io/en/stable/) template for UKHSA Data Science and analytical projects.

It contains a folder and file structure for your project, as well as configured hooks & GitHub Actions.

The purpose of this project structure is to:

- Encourage individuals to understand where to find code/items
- Enable collaboration across teams
- Standardise the way we work including QA best practices, making it easier to share code and data.

Point of Contact: [qa.datascience@ukhsa.gov.uk](mailto:qa.datascience@ukhsa.gov.uk)

If you would like to contribute to the project, see our [contributing guidelines](CONTRIBUTING.md).

The repo contains:

- A README.md file, and readmes throughout the file structure explaining the common purpose of the locations.
- A CONTRIBUTING.md file
- A CODE_OF_CONDUCT.md file
- pre-commit hooks
- GitHub Actions workflow files
- A copy of the [Duck Book](https://best-practice-and-impact.github.io/qa-of-code-guidance/checklist_lower.html) template in the docs folder for maintainers to fill in
- [Lots of other commonly used folders and files](#folder-structure)

Repos built using this template have:

- *Common structure*, to make it easy to know where to find code/items and makes it easier to collaborate/ onboard people.
- *Shared functions*, to reduce duplication and simplify work.
- *Continuous Integration*, used by default to automate `pre-commit` hooks through GitHub Actions and set up the folders to easily add extra CI/CD workflows, see [docs](https://github.com/UKHSA-Internal/ukhsa-project-template/blob/main/%7B%7B%20cookiecutter.repo_name%20%7D%7D/docs/README.md#hooks-with-pre-commit)
- *Quality assurance*, to align with [ONS QA standards](https://best-practice-and-impact.github.io/qa-of-code-guidance/intro.html). Work should be reviewed by a peer before merging.
- *Shared functions* reduce duplication and simplify work.
- *Continuous Integration* is used by default to automate `pre-commit` hooks through GitHub Actions and set up the folders to easily add extra CI/CD workflows, see [docs](https://github.com/UKHSA-Internal/ukhsa-project-template/blob/main/%7B%7B%20cookiecutter.repo_name%20%7D%7D/docs/README.md#hooks-with-pre-commit)
- *Quality assurance* aligned with [ONS QA standards](https://best-practice-and-impact.github.io/qa-of-code-guidance/intro.html). Work should be reviewed by a peer before merging.

All project structures are a compromise but this is essential for us to work together.

For queries, bugs, suggestions, or help getting set up with this template you can raise an issue or comment on the [GitHub repository](https://github.com/ukhsa-internal/ukhsa-project-template/issues/new/choose).

Alternatively, please contact <qa.datascience@ukhsa.gov.uk>

## Installation and setup
### Setup
#### Hooks with [pre-commit](https://pre-commit.com/)

Pre-commit is a Python tool for managing pre-commit hooks so that issues are fixed before they end up in the commit history of git. By installing pre-commit in a repo you can ensure your code is of the correct standard before you commit it and prevent issues when conducting PRs, freeing you up to focus on actual code review.


Depending on Package Manager use:
```bash
pip install pre-commit
```
or

```bash
conda install -c conda-forge pre-commit
```
```bash
# Run the following command in the repo directory to set up the git hook scripts
pre-commit install
```

The hooks currently installed are:

- [Ruff](https://github.com/astral-sh/ruff-pre-commit) Linter - currently configured to check for Python Docstring PEP-257 compliance
- [Several built-in hooks](https://github.com/UKHSA-Internal/ukhsa-project-template/blob/000a3efecd64cdfc7e547ff802b1d23f821ae2b2/%7B%7B%20cookiecutter.repo_name%20%7D%7D/.pre-commit-config.yaml#L4) from [pre-commit](https://github.com/pre-commit/pre-commit)
- [style-files](https://github.com/lorenzwalthert/precommit) R style checks
- [black](https://https://pypi.org/project/black/)
- [nbstripout](https://github.com/kynan/nbstripout)
  
Flake8 is included but not enabled. If you would like to run styling/linting they can be enabled by removing the "#" signs from the relevant hook at `.pre-commit-config.yaml`.

 ```
  # - repo: 'https://github.com/pycqa/flake8'
  #   rev: 4.0.1
  #   hooks:
  #     - id: flake8
  #       args: ['--ignore=E203,E266,E402,E501,W503,F401,F403', # https://lintlyci.github.io/Flake8Rules/
  #              '--max-line-length=88',
  #              '--max-complexity=18',
  #              '--select=B,C,E,F,W,T4,B9']
```

Ruff Formatter is included but not enabled. It could be added by removing the '#' signs at `.pre-commit-config.yaml`.
 ```
   - repo: https://github.com/astral-sh/ruff-pre-commit
      rev: v0.4.10
      hooks:
      # Run the linter.
         - id: ruff
           types_or: [ python, pyi,jupyter ]
           args: [--fix, --show-fixes]
      # # Run the formatter.
      # - id: ruff-format
      #   types_or: [ python, pyi, jupyter ]
      #   #args: [--fix ]
 ```

 The R 'style-files' hook is also not enabled by default. This can be enabled by removing the '#' signs on the following lines in `.pre-commit-config.yaml`: 
 ```
 # - repo: https://github.com/lorenzwalthert/precommit
 #   rev: v0.4.3
 #   hooks: 
 #   -   id: style-files

 ```
7. Add all files that you want to commit
```bash
git add .
```
8. Commit your files. This will run pre-commit against all your staged files in the repo
```bash
git commit -m "first commit"
```
9. Push your local repository to the remote repository:

```bash
git push -u origin main
```
### Automation & CI/CD

GitHub Actions are automatically created and the workflow can be controlled from `~/.github/workflows`. Additional workflows (e.g. `black`) can be added directly or existing workflows can be altered. The `pre-commit` workflow content is controlled by the `~/.pre-commit-config.yaml` file and additional steps can be included if required.
GitHub Actions *must* be enabled on the repository for the actions to work. If they are not enabled you may be able to activate them yourself as an admin on the repository (in repo go "Settings" -> "Actions" -> "General" -> Allow actions at the level you need). If you are not able to do this, a ticket can be submitted to the Help Desk to have GitHub Actions enabled on the repository.

## Folder Structure

The following folder structure describes how we recommend you use this template to organise your files.

The folder structure contains readme files that describe the purpose of each folder and how to use it.

```
.
├── .github/                 # GitHub templates and workflows
├── config/                  # Local folder to store secrets etc that is not committed
├── data/
│   ├── interim/             # Intermediate data that has been transformed
│   ├── processed/           # The final, canonical data sets for modeling
│   └── raw/                 # The original, immutable data dump
├── docs/               
│   └── pull_request_template.md  # Template for pull requests
|   └── QA_checklist_template_lower.md # The Duck Book lower checklist for users to fill in and distribute alongside their repo
├── models/                 # Trained and serialised models, model predictions, or model summaries
├── notebooks/
│   ├── project/theme/       # Each project/theme has a folder for related work
│   └── NOTEBOOK_NAMED_CONVENTION.ipynb  # A notebook about a topic with a ticket number and description
├── outputs/                 # Generated analysis as HTML, PDF, LaTeX, graphics and figures
├── R                        # R scripts
├── renv/                    # R package management
├── src/                     # Source code for use in this project
│   └── __init__.py          # Makes src a Python module 
├── tests/                   # All tests for this project
├── .gitignore
├── .pre-commit-config.yaml
├── setup.py                 # Makes project pip installable (pip install -e .) so src can be imported
├── LICENSE
├── README.md                # The top-level README for developers using this project. Contributors should update this with information about the project.
├── requirements.txt         # The requirements file for reproducing the analysis environment, e.g. generated with `pip freeze > requirements.txt`
├── CONTRIBUTING.md          # Guidelines for contributing to this project focussing on the technical aspects
├── CODE_OF_CONDUCT.md       # Guidelines for contributing to this project outlining expected behaviour and conduct for all contributors
└── data_catalogue.ini       # The file storing data locations for access across the project and is ignored by default
```

This repository was created using the [UKHSA Project Template](https://github.com/UKHSA-Internal/ukhsa-project-template).