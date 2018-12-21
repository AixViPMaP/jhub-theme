## Makefile for compilation of JupyterHub CSS files
#  with a customized `variable.less` file
#
#  Copyright 2018 Lukas Koschmieder
#  Copyright 2018 Mingxuan Lin

JhubGit:=https://github.com/jupyterhub/jupyterhub
SRC=jupyterhub-$(VER)
STATIC_DIR:=share/jupyterhub/static
VAR_LESS:=aixvipmap_variables.less
PATCH_STYLE_LESS=s/(@import ".\/variables.less";)/\1\n@import ".\/$(VAR_LESS)";/

# Detect jupyterhub version and prefix
VER:=$(shell    python -c 'import jupyterhub as h;print(h.__version__)')
PREFIX:=$(shell python -c 'import sys;print(sys.prefix)')

VER_LT8=$(shell python -c 'print([int(x) for x in "$(VER)".split(".")]>=[0,9,0])')
ifeq ($(VER_LT8),False)
  STATIC_DIR:=share/jupyter/hub/static
endif

.PHONY: install

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
install: $(SRC)/$(STATIC_DIR)/css
	cp -r "$<" "$(PREFIX)/$(STATIC_DIR)/"
	cp "./favicon.ico" "$(PREFIX)/$(STATIC_DIR)/"
	cp "./jupyter.png" "$(PREFIX)/$(STATIC_DIR)/images/"

