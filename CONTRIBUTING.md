# Contributing to repo_name

Thank you for your interest in contributing to repo_name!

## How to contribute

In the first instance, please contact the project team to discuss your proposed contribution. This will help to ensure that your contribution is aligned with the project goals and that you are aware of any relevant project constraints.

## GUIDANCE/ GROUND RULES

1. Store notebooks in the `notebooks` folders based on thematic labelling e.g. "Project_name", "theme_x", (...).
2. Within a thematic folder, only notebooks should be stored and they should be named as per the convention above.
3. Notebooks should be cleared of output before committing. This is enforced by default on Dash with checks using pre-commit and github actions. (Further details below)
4. No data, output or blob files (.DOC, .XLS, .PDF, .HTML, .PNG, .JPEG or .SVG) should ever enter the repository.
5. Any raw or intermediate data files created should be stored in the `data` folder. No CSV/RDS/JSON/favourite_data_format in any folder aside `data`.
6. All outputs (e.g images containing graphs etc) should be stored into the `outputs` folder or preferable written to *S3*.
7. The default location for outputs or objects (images, models etc) that need to be persisted and shared is *S3*.
8. All `.py` or `.R` files should be stored in `src`.
9. Pytest is the preferred test framework.  All tests should be stored in the tests folder and contained in files beginning `test_XXX.py` so that they can be detected by pytest. (Further details below)
10. The folder `models` can be deleted if not required.
11. Pushing to `main` / `master` should be disabled and code reviewed by a peer before entering `main` / `master`.

### Reporting bugs

If you find a bug, please report it in the [issue tracker](repo_name) with the following information:

1. A clear and descriptive title
2. Any associated JIRA ticket number
3. Any details of the environment you are using (e.g. operating system, Python version, etc.)
4. The expected behavior
5. The actual behavior
   - Include screenshots if possible
   - Include error messages if possible
6. Any steps to reproduce the behavior
7. Possible solutions

The repository maintainers will then be able to capture the relevant information, and if necessary, make a Jira ticket to track the bug.

### Suggesting enhancements

If you have an idea for an enhancement, please suggest it in the [issue tracker](repo_name) with the following information:

1. A clear and concise description of what the problem is. Ex. I'm always frustrated when [...]
2. Any alternative solutions or features you've considered.
3. A link to any relevant issues, pull requests, and Jira tickets.

### Pull requests

If you would like to contribute code, please do the following:

1. Clone the repository to your work space.
2. Make a new branch following naming convention: `JIRAticket123-a-description`.
3. Push your branch to the repository.
4. Open a pull request to the `develop/dev` or if there is no development branch, the `main/master` branch.
5. Request a code review from one of the team authors.
   * Pushing to `main` should be disabled and code reviewed by a peer before entering `main`.

## Managing Secrets

Secrets files (`config/secrets.ini`) consist of a set of key-value pairs that store parameters that change depending on where our code is ran and by whom.

This is typically important for storing user details for connecting to databases such as usernames, but can be used for other things such as project folder paths. 

It is **crucial** that this file does not enter version control.

Other users will need their own copy of the secrets file with the same keys but their own values to run others' code. They can also easily integrate the same keys into their own code and avoid duplication.

### Example secrets/user_secrets.ini

This is an example of the user_secrets.ini

```ini
[project]
projectroot = C:\Users\JohnSmithJBC\Documents\jbc-estimates

[user]
name = John Smith
username = John.Smith@test-and-trace.nhs.uk
```

You will need to make your own `config/secrets.ini` file, copy this in and edit with your own details.
Do not use quote marks (`'`, `"`) as the value is read in as is.

Over time new key-values might get added.

### Using in python

We recommend using configparser: https://docs.python.org/3/library/configparser.html

To use the `secrets.ini` file you can do the following:

1. `import configparser`
2. make the config object
3. define the path to the secrets file - this can be relative!
4. read in the secrets file
5. access the secrets 

As the secrets file will always be in the same place in the repo for everyone, you can use relative paths to read in the file. 

We recommend all members of the team store the secrets file within `/config/` for consistency. 

You can then read project root paths etc from there. 

```python
import configparser
import os


# make config object
secrets = configparser.ConfigParser()

# you might need to update this to your system's path
# read in the secrets file
path_to_secrets = os.path.join("..", "..", "config", "secrets.ini")
secrets.read(path_to_secrets)
```
The key value pairs within the ini file are read in as a structure similar to a nested dictionary.

Once read, you can access different elements of the configuration file like this:
```
secrets["user"]["name"]
secrets.sections()
list(secrets["user"])
```

## How to use the Data Catalogue file

The data catalogue files (`/data_catalogue.ini`) consist of a set of key-value pairs that store parameters related to our data marts.

### Example /data_catalogue.ini

This is an example of the data_catalogue.ini. It consists of a series of sections for each data mart we connect to. In future the keys could grow to include other details we need about the data source. 

```ini
[s3_connection_bucket_example]
bucket = dash-123456789-prod-s3-data-wip
cases_folder = PROJECT/NAME/source_data/cases
deaths_folder = PROJECT/NAME/source_data/deaths

[s3_connection_file_example]
path = s3://dash-123456789-prod-s3-data-wip/PROJECT/NAME/source_data/lookups/encodings.json

[db_connection_had]
database = HealthAnalysisDirectorate
server = sae-prd-mart-sql.database.windows.net

[db_connection_ref]
database = reference
server = sae-prd-mart-sql.database.windows.net
```

Over time new key-values might get added.

### Using in python

We recommend using configparser: https://docs.python.org/3/library/configparser.html

 To use the `data_catalogue` file you can do the following:

1. `import configparser`
2. make the config object
3. define the path to the data_catalogue file - this can be relative!
4. read in the data_catalogue file
5. access the data_catalogue 

```python
import configparser
import os

# make config object
data_catalogue = configparser.ConfigParser()

# you might need to update this to your system's path
# read in the data_catalogue file
path_to_data_catalogue = os.path.join(
    "..", "..", "data_catalogue", "data_catalogue.ini"
)
data_catalogue.read(path_to_data_catalogue)
```
The key value pairs within the ini file are read in as a structure similar to a nested dictionary.

Once read, you can access different elements of the configuration file like this:
```
data_catalogue["s3_connection_bucket_example"]["bucket"]
data_catalogue.sections()
list(data_catalogue["db_connection_had"])
```

## Automated checks run locally and on GitHub

### Hooks with [pre-commit](https://pre-commit.com/)

Pre-commit is a python tool for managing pre-commit hooks so that issues are fixed before they end up in the commit history of git. By installing pre-commit in a repo you can ensure your code is of the correct standard before you commit it and prevent issues when conducting PRs, freeing you up to focus on actual code review.

```bash
pip install pre-commit

# Run the following command in the repo directory
pre-commit install

# This command runs pre-commit against all files in the repo. Use this the first time it is installed
pre-commit run --all-files
```

### GitHub Actions

GitHub Actions are pre-configured and can be enabled by adding relevant `.yml` files in the folder: `.github/workflows`. Additionally the `pre-commit` checks can be altered by changing the `~/.pre-commit-config.yaml` in the repositories root. <br>
GitHub Actions must be enabled on the remote repository. This can be done by going into the repository then "Settings" -> "Actions" -> "General" -> Allow the action level you require. If this is unavaliable, a request can be put through the service desk to request GitHub Actions for your repository.

### Local vs Remote

`pre-commit` hooks, nbstripout and a variety of testing & automation can be run locally (on your laptop/AWS instance/notebook) or remotely (on GitHub through GitHub Actions). The difference between these is running locally allows us to protect our GitHub repositories from data & code security risks. By running `nbstripout` locally before pushing to GitHub, the potentially sensitive outputs in your notebooks can be removed before being put onto GitHub.

Why is this useful? This will prevent sensitive data from being shared either around the organisation or even into the public, and plots in notebooks take up storage so our repositories become inefficient.

GitHub Actions allows coders to test their code (alongside a lot of other capabilities) on a platform that others can see. This allows us to robustly understand issues in our repositories and monitor organisational problems. This does not allow us to defend our repositories from sensitive data entering, which must be done locally.

### Testing using [Pytest](https://docs.pytest.org/en/stable/getting-started.html#create-your-first-test)

Pytest is a common python testing framework. Tests are important for ensuring that changes to code do no break existing functionality and can be run in an automated manner to check this. Tests should be stored in the "tests" directory and be preceded with "test_XXX.py" so that pytest can identify them. Tests can be run as part of the pre-commit GitHub Actions on pull requests.
