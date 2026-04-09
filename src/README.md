# src folder

This folder contains files and information specific to the source code in the repository.

Storing source code in the `src` folder is useful for a few key reasons:

* It reduces repetitive code across the codebase, making it easier to maintain and update.
* It is easier to find the source code in the repository as it is all in one place
* It is easier to test the source code as it is all in one place.
* It is easier to manage a package if the source code is in one place.

⚠️ The [`targets` package](https://books.ropensci.org/targets/) uses the `R` folder as the default location for R functions.

## src in Python

### Scripts

* 💡 The easiest way to keep your scripts clean and free of repetition is to store functions in the `src` folder and import them into the scripts.

When using scripts with Python, even though storing functions in the `src` folder is standard practice, Python is not able to import modules from the `src` folder by default. This can easily be fixed in a few ways. Below is one example.

* Lets say you had the following file structure:
  
```
.
├── src
│   └── source_function.py #contains print_function
└── scripts
    └── script.py
```

Lets say src/source_function.py contains the following code:

```python
def print_function():
    print("Hello World")
```

In `script.py` you can add the following code to the top of the script to allow you to call the function.

```python
# Import the function from the src folder

import sys
sys.path.append('src')

from source_function import print_function

# Call the function
print_function()
```

### Python Package

* ❓ Why is there a blank `__init__.py` file in the `src` folder?
* 🖐️ Because the `src` folder is being treated as a location for functions that can be part of a package.
  * Because the functions are maintained in `src`, when the project is ready to be turned into a package, the functions are already in the correct location.

As well as relying on scripts, you can call src functions when the folder is treated like a package.

In the src folder, `__init__.py` is a blank file that tells Python that the folder is a package.

```
.
├── src
│   └── source_function.py #contains 
│   └── __init__.py
└── setup.py
```

In the `src files`, you can add a section to the bottom of the file that will run the function when the file is called directly, but not when it is imported. This is useful for testing the function.

In the src/source_function.py file, you can add the following code to the bottom of the file.

```python
def print_function():
    print("Hello World")

if __name__ == "__main__":
    print_function()
```

Then you can run `bash python -m src.function` in the terminal to run the function.

ℹ️ This will only work for packages, not for scripts. For example `python scripts/script.py` will not work, but `python -m src.src_filename` would work.

Taking this one step further, you can add a `setup.py` file to the root of the repository. This will allow you to install the package locally and call the function from anywhere on your computer.

`setup.py` should contain something like this:

```python
from setuptools import setup, find_packages

setup(
    name="mypackage",
    version="0.1",
    packages=find_packages(),
)
```

Then you can run the following pip command in the root of the repository to install the package locally.

```bash
pip install -e .
```  

Then you can call the function from anywhere on your computer.

```python
from mypackage.source_function import print_function

print_function()
```
