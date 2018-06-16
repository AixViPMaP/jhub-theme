## Makefile for compilation of JupyterHub CSS files
#  with a customized `variable.less` file
#
#  Copyright 2018 Mingxuan Lin

JhubGit=https://github.com/jupyterhub/jupyterhub
SRC=jupyterhub-$(VER)
STATIC_DIR=share/jupyterhub/static
PATCH_STYLE_LESS=s/@import ".\/variables.less";/@import ".\/variables.less";\n@import ".\/aixvipmap_variables.less";/
# Detect jupyterhub version and prefix
VER=$(shell python -c 'import jupyterhub as h;print(h.__version__)')
PREFIX=$(shell python -c 'import sys;print(sys.prefix)')

.PHONY: install

# Download source tree from GitHub
$(SRC):
	wget "$(JhubGit)/archive/$(VER).zip"
	unzip "$(VER).zip"

# Running npm install and copy source less files to the static folder
$(SRC)/$(STATIC_DIR)/less: $(SRC)
	cd "$(SRC)" && python setup.py js

# Compile CSS files
$(SRC)/$(STATIC_DIR)/css:  $(SRC)/$(STATIC_DIR)/less  aixvipmap_variables.less
	cp ./aixvipmap_variables.less "$</"
	sed -i -e '$(PATCH_STYLE_LESS)'  "$</style.less"
	cd "$(SRC)" && python setup.py css

# Install to system location or Virtual environment
install: $(SRC)/$(STATIC_DIR)/css
	cp -r "$<" "$(PREFIX)/$(STATIC_DIR)/"
