# Configurable Variables
PYTHON_NAME := python
VENV_NAME := .venv
ENTRY_POINT_NAME := main
REQUIREMENTS_FILE_NAME := requirements

# VENV Paths
VENV_PATH_WINDOWS := $(VENV_NAME)\Scripts
VENV_PATH_UNIX := $(VENV_NAME)/bin

# Execute Custom Commands
execute_custom:
	echo 'run command 1';
	echo 'run command 2';

# Setup VENV
setup_venv:
ifeq ($(OS),Windows_NT)
	if not exist $(VENV_NAME) $(PYTHON_NAME) -m venv $(VENV_NAME) && \
	$(VENV_PATH_WINDOWS)\pip install --upgrade pip && \
	$(VENV_PATH_WINDOWS)\pip install pipdeptree
else
	test -d $(VENV_NAME) || $(PYTHON_NAME) -m venv $(VENV_NAME) && \
	$(VENV_PATH_UNIX)/pip install --upgrade pip && \
	$(VENV_PATH_UNIX)/pip install pipdeptree
endif

# Install Requirements
install_packages: setup_venv
ifeq ($(OS),Windows_NT)
	$(VENV_PATH_WINDOWS)\pip install -r $(REQUIREMENTS_FILE_NAME).txt && \
	$(VENV_PATH_WINDOWS)\pip freeze > $(REQUIREMENTS_FILE_NAME)_lock.txt && \
	$(VENV_PATH_WINDOWS)\pipdeptree && \
	$(VENV_PATH_WINDOWS)\pipdeptree > pipdeptree.txt
else
	$(VENV_PATH_UNIX)/pip install -r $(REQUIREMENTS_FILE_NAME).txt && \
	$(VENV_PATH_UNIX)/pip freeze > $(REQUIREMENTS_FILE_NAME)_lock.txt && \
	$(VENV_PATH_UNIX)/pipdeptree && \
	$(VENV_PATH_UNIX)/pipdeptree > pipdeptree.txt
endif

# Show Installed Packages
show_packages: setup_venv
ifeq ($(OS),Windows_NT)
	$(VENV_PATH_WINDOWS)\pipdeptree
else
	$(VENV_PATH_UNIX)/pipdeptree
endif

# Uninstall Virtual Environment
clean_venv:
ifeq ($(OS),Windows_NT)
	if exist $(VENV_NAME) rmdir /s /q $(VENV_NAME)
	if exist $(REQUIREMENTS_FILE_NAME)_lock.txt del /q $(REQUIREMENTS_FILE_NAME)_lock.txt
	if exist pipdeptree.txt del /q pipdeptree.txt
else
	test -d $(VENV_NAME) && rm -rf $(VENV_NAME)
	test -f $(REQUIREMENTS_FILE_NAME)_lock.txt && rm -f $(REQUIREMENTS_FILE_NAME)_lock.txt
	test -f pipdeptree.txt && rm -f pipdeptree.txt
endif

# Uninstall Virtual Environment and Install Requirements
clean_install_packages: clean_venv install_packages

# Django help
django_help:
ifeq ($(OS),Windows_NT)
	$(VENV_PATH_WINDOWS)\django-admin version && \
	$(VENV_PATH_WINDOWS)\django-admin help
else
	$(VENV_PATH_UNIX)/django-admin version && \
	$(VENV_PATH_UNIX)/django-admin help
endif

# Django Start Project
django_start_project: django_help
ifeq ($(OS),Windows_NT)
	if not exist core $(VENV_PATH_WINDOWS)\django-admin startproject core .
else
	test -d core || $(VENV_PATH_UNIX)/django-admin startproject core .
endif

# Django Delete Project
django_delete_project:
ifeq ($(OS),Windows_NT)
	if exist core rmdir /s /q core
	if exist manage.py del /q manage.py
else
	test -d core && rm -rf core
	test -f manage.py && rm -f manage.py
endif
