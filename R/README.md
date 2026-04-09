# R folder

This folder contains files and information specific to the R scripts in the repository.

Storing R scripts in the `R` folder is useful for a few key reasons:

* It reduces the repetitive code across the codebase, which makes it easier to maintain and update.
* It is easier to find the R scripts in the repository as they are all in one place.
* New contributors familiar with R expect to find R scripts and understand how they are used in the repository.
* The [`targets` package](https://books.ropensci.org/targets/) uses the `R` folder for extracting R functions.

However, there are some drawbacks to storing R scripts in the `R` folder:

* The [`orderly` package](https://cran.r-project.org/web/packages/orderly/index.html) uses `src` as the default folder for R scripts, so you will need to specify the `R` folder when using the `orderly` package.
* Python users will expect all functions to be in the `src` folder, so bear this in mind.