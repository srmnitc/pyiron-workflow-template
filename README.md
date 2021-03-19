# pyiron publication template
This is a template repository how you can publish your calculation with pyiron. It consists of the repository [itself](https://github.com/pyiron/pyiron-publication-template), a small [website](http://pyiron.org/pyiron-publication-template/) created with Jupyterbook and a [mybinder environment](https://mybinder.org/v2/gh/pyiron/pyiron-publication-template/HEAD?filepath=notebooks%2Fexample.ipynb) for testing the calculation. 

You can fork this repository and populate it with your own data.

## Repository structure 

### notebooks 
The notebooks folder contains one or more jupyter notebooks. These notebooks are executed during the unit tests and included in the website for easy readablity. 

### conda environment
The binder folder includes the `environment.yml` file which defines the conda environment required to execute the notebooks in the `notebooks` folder. An existing environment can be exported using `conda env export > environment.yml` but it is recommended to reduce the environment to the minimal requirements as a large environment is less performant. 

### calculation
The `calculation` folder includes previous calculation results which are published with in this repository. In this example the calculation were created using:

```
from pyiron_atomistics import Project
pr = Project("old_calculation")
job = pr.create.job.Lammps(job_name="lmp_si")
job.structure = pr.create.structure.ase.bulk("Si")
job.run()
pr.pack(destination_path="save")
```

The resulting files `export.csv` and `save.tar.gz` have been copied to the calculation repository.

### resources 
Just like the pyiron resources folder this folder can include additional resources like links to special executables or additional parameter files. In this example the resource directory contains a special LAMMPS potential named `Si-quip-xml` which is required for the current notebook. 

### jupyterbook 
The website for the repository is generated using jupyter book. It is configured with the config file `_config.yml`. Finally additional images for the jupyterbook can be stored in `website/images`. In this example case the `images` folder contains the dark pyiron logo `logo_dark.png`. The jupyterbook is build using the github action `.github/workflows/book.yml` and it is deployed to github pages using `.github/workflows/deploy.yml`. Both github actions internally use the conda environment defined in `.github/ci_support/environment.yml`. But there should be no need to modify these files, only the `_config.yml` has to be adjusted by the user.

### mybinder
Besides the conda environment in `binder/environment.yml` the `binder/postBuild` script is used to import the calculations stored in `calculation` and install `NGLview` for both jupyter notebooks and jupyter lab. Finally the pyiron environment on mybinder is configured using the `binder/.pyiron` file in this repository.

### continous integration 
The rest of the files in the repository are used to test the environment. For continous integration the github actions are defined in `.github/workflows/notebooks.yml`. Again the mybinder environment `binder/environment.yml` to install all the dependencies, afterwards pyiron is configured in the test environment using `.github/ci_support/pyironconfig.py` and finally the notebooks are executed using `.github/ci_support/build_notebooks.sh`. Usually there is no need for the user to adjust any of these files other than the mybinder environment `binder/environment.yml`.

## Step by step
* Move your notebooks to the `notebooks` folder and remove the example notebook `notebooks/example.ipynb`.
* Update the `environment.yml` file with the conda dependencies required for your notebook. 
* Include the export of your pyiron database in the `calculation` folder or in case no calculation are required you can remove the `save.tar.gz` archive and the `export.csv` database backup file. 
* Include additional pyiron resources in the `resources` folder if required, otherwise the `resources folder can be deleted.
* Finally you can update the website configuration file `_config.yml` to include the repository name, author and link to the website.