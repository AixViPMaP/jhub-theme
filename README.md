
# JupyterHub Theme

This theme is based on a custom RWTH Aachen Bootstrap v3 theme which is available [here](https://git.rwth-aachen.de/icmeaix/rwth-bootstrap).

## Build

```bash
lessc less/style.less css/style.css
lessc --clean-css css/style.css css/style.min.css
```

lessc is available via npm

```
npm install -g less
npm install -g less-plugin-clean-css
```

## Install

Temporary solution: Copy [css](css) and [components](components), [favicon.ico](favicon.ico) and [images](images) to JupyterHub **static** directory replacing existing files.
