## Makefile for compilation of JupyterHub CSS files
#  with a customized `variable.less` file
#
#  Copyright 2018 Mingxuan Lin
#  Copyright 2018 Lukas Koschmieder

JhubGit:=https://github.com/jupyterhub/jupyterhub
SRC=jupyterhub-$(VER)
VAR_LESS:=aixvipmap_variables.less
PATCH_STYLE_LESS=s/(@import ".\/variables.less";)/\1\n@import ".\/$(VAR_LESS)";/

# Detect jupyterhub version and prefix
VER:=$(shell    python -c 'import jupyterhub as h;print(h.__version__)')
PREFIX:=$(shell python -c 'import sys;print(sys.prefix)')
ifneq (,$(wildcard ./$(SRC)/setup.py))
    STATIC_DIR:=$(shell cd $(SRC) &&  python -c 'import os,setup as s;print(os.path.relpath(s.static))' )
else
	STATIC_DIR:=share/jupyterhub/static
endif

.PHONY: install _install

# Download source tree from GitHub
$(SRC):
	wget "$(JhubGit)/archive/$(VER).zip"
	unzip "$(VER).zip"

# Running npm install and copy source less files to the static folder
$(SRC)/$(STATIC_DIR)/less: $(SRC)
	cd "$(SRC)" && python setup.py js

# Compile CSS files
$(SRC)/$(STATIC_DIR)/css:  $(SRC)/$(STATIC_DIR)/less  $(VAR_LESS)
	cp ./$(VAR_LESS) "$</"
	sed -i -re '$(PATCH_STYLE_LESS)'  "$</style.less"
	cd "$(SRC)" && python setup.py css

# Install to system location or Virtual environment
_install: $(SRC)/$(STATIC_DIR)/css ./static/*
	cp -r $^ "$(PREFIX)/$(STATIC_DIR)/"
install: $(SRC)
	make -f $(lastword $(MAKEFILE_LIST)) _install
