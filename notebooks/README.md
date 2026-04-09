# Notebooks

This folder is for storing notebooks, usually in the `.ipynb` format. Notebooks are useful for exploratory analysis and for sharing results with others. Notebooks should be cleared of output before committing. This is enforced by default using pre-commit and notebook stripout.

`nbstripout` is a tool we use via pre-commit to ensure no notebook outputs are accidentally pushed to the repo.

There should be no need to manually install `nbstripout``, as it is installed as part of the pre-commit hook.

If you do for some reason need to manually install `nbstripout`, you can do so with the following command:

```bash
pip install nbstripout
nbstripout --install
nbstripout notebooks/*.ipynb
```

ℹ️ Note that whilst `black` will apply to Python in `ipynb` files, the counterpart linter in R, `styler`, will not be able to format the R code within a notebook.
