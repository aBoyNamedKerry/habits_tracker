This is an itemised checklist for the QA process within UKHSA

Please delete the sections below that are not relevant (for example delete notebook section if not implemented)

### JIRA ticket Number 
_requester to update_

### Explanation of PR 
_requester to update_

# How to Create a Pull Request 
- This is for the person raising this Pull Request


1) **Explain what needs to be reviewed** 
- Update the JIRA Ticket number (if one exists)
- Put a description of what this PR contains above number in the header 

2) **Update the 'Code Review' section** below. Every checkboxes left on this PR is a type of review you are requesting.
- If you have no new Data Sources, then delete the 'Data Source' section. Similarly, if you have no changes to documentation, delete the 'Documentation' section. (See the 'JBC Review Process' link below for further details).
- The review of Notebooks defaults to a Smoke Test. If you require a Full Review, please change it. See the 'JBC Review Process' link for further details of what that means)

3) **Assign appropriate labels**, showing whether this is a 'New Feature'/'Bug Fix'/'Minor Change' etc. - This is so that colleagues can prioritise bug fixes and smaller changes. (Labels are added to the right of this panel).

4) **Add explanations** to the top of this PR comment, if there is no Jira ticket associated with this PR, or you have other important points to flag-up to the reviewer.

5) **Delete this section**, i.e. 'How to Create a Pull Request', as it's not relevant to the reviewer

---

# Code Review

## Minimum standards

**Reviewing**: Please read  [ONS QA of code guidance](https://best-practice-and-impact.github.io/qa-of-code-guidance/intro.html) and flag any issues in the PR related to items from the [lower quality assurance checklist](https://best-practice-and-impact.github.io/qa-of-code-guidance/checklist_lower.html). The reviwer should at least check the following conditions are met by the code in the PR.

## Quality assurance checklist

Quality assurance checklist from [the quality assurance of code for analysis and research guidance](https://best-practice-and-impact.github.io/qa-of-code-guidance/intro.html).

### Modular code

- [ ] Individual pieces of logic are written as functions. Classes are used if more appropriate.
- [ ] Repetition in the code is minimalised. For example, by moving reusable code into functions or classes.

### Good coding practices

- [ ] Names used in the code are informative and concise.
- [ ] Code logic is clear and avoids unnecessary complexity.
- [ ] Code follows a standard style, e.g. [PEP8 for Python](https://www.python.org/dev/peps/pep-0008/) and [Google](https://google.github.io/styleguide/Rguide.html) or [tidyverse](https://style.tidyverse.org/) for R.

### Project structure

- [ ] A clear, standard directory structure is used to separate input data, outputs, code and documentation.

### Code documentation

- [ ] Comments are used to describe why code is written in a particular way, rather than describing what the code is doing.
- [ ] Comments are kept up to date, so they do not confuse the reader.
- [ ] Code is not commented out to adjust which lines of code run.
- [ ] All functions and classes are documented to describe what they do, what inputs they take and what they return.
- [ ] Python code is [documented using docstrings](https://www.python.org/dev/peps/pep-0257/). R code is [documented using `roxygen2` comments](https://cran.r-project.org/web/packages/roxygen2/vignettes/roxygen2.html).

### Project documentation

- [ ] A README file details the purpose of the project, basic installation instructions, and examples of usage.
- [ ] Where appropriate, guidance for prospective contributors is available including a code of conduct.
- [ ] If the code's users are not familiar with the code, desk instructions are provided to guide lead users through example use cases.
- [ ] The extent of analytical quality assurance conducted on the project is clearly documented.
- [ ] Assumptions in the analysis and their quality are documented next to the code that implements them. These are also made available to users.
- [ ] Copyright and licenses are specified for both documentation and code.
- [ ] Instructions for how to cite the project are given.

### Configuration

- [ ] Credentials and other secrets are not written in code but are configured as environment variables.
- [ ] Configuration is written as code, and is clearly separated from code used for analysis.
- [ ] The configuration used to generate particular outputs, releases and publications is recorded.

### Testing

- [ ] Core functionality is unit tested as code. See [`pytest` for Python](https://docs.pytest.org/en/stable/) and [`testthat` for R](https://testthat.r-lib.org/). 
- [ ] Code based tests are run regularly, ideally being automated using continuous integration.
- [ ] Bug fixes include implementing new unit tests to ensure that the same bug does not reoccur.
- [ ] Informal tests are recorded near to the code.
- [ ] Stakeholder or user acceptance sign-offs are recorded near to the code.

### Dependency management

- [ ] Required passwords, secrets and tokens are documented, but are stored outside of version control.
- [ ] Required libraries and packages are documented, including their versions.
- [ ] Working operating system environments are documented.
- [ ] Example configuration files are provided.

### Logging

- [ ] Misuse or failure in the code produces informative error messages.
- [ ] Code configuration is recorded when the code is run.
