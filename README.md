
# JupyterHub Theme

This theme is based on a custom RWTH Aachen Bootstrap v3 theme which is available [here](https://git.rwth-aachen.de/icmeaix/rwth-bootstrap).

## Install to Anaconda environment

```bash
conda install -c conda-forge jupyterhub nodejs
make install
```

### Update

This project should be compiled with source `less` files from the same version of `jupyterhub` as the system-wide installation. After updating `jupyterhub`, checkout this project in a new folder and run `make install` again.

# License

MIT license
Copyright 2018
- Lukas Koschmieder
- Mingxuan Lin
- Alper Topaloglu
