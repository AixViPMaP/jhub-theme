
# Jupyterhub Theme

## Requirements
Less Compiler: lessc

    npm install -g less
    npm install -g less-plugin-clean-css

Download RWTH Bootstrap from https://git.rwth-aachen.de/icmeaix/rwth-bootstrap

## Compile
Compile changes with:

    cd ~/jupyterhub/share/jupyterhub/static
	
    lessc less/style.less css/style.css
    lessc --clean-css css/style.css css/style.min.css

## Setting up bootstrap

Copy the 'less' and 'dist' folder from RWTH bootstrap into '~/jupyterhub/share/jupyterhub/static/components/bootstrap/' and replace both existing folders.

## Restart Jupyterhub
    Jupyterhub


