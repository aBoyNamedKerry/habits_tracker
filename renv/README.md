# renv folder

Our R dependencies can be managed using the [`renv` package](https://rstudio.github.io/renv/). This folder contains files and information specific to the `renv` package.

To install the dependencies for this repository, run the following command in the terminal:

```bash
renv::restore()
```

You can validate that the dependencies are installed correctly by running the following command in the terminal:

```bash
renv::status()
```
