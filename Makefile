#### Variables ####

export ROOT_DIR ?= $(PWD)
export SRS_ROOT_DIR ?= $(ROOT_DIR)

export ANSIBLE_NAME ?= ansible-srs
export HOSTS_INI_FILE ?= hosts.ini

export EXTRA_VARS ?= ""

#### Start Ansible docker ####

srs-ansible:
	export ANSIBLE_NAME=$(ANSIBLE_NAME); \
	sh $(SRS_ROOT_DIR)/scripts/ansible ssh-agent bash

#### a. Debugging ####
srs-pingall:
	ansible-playbook -i $(HOSTS_INI_FILE) $(SRS_ROOT_DIR)/pingall.yml \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

#### b. Provision docker ####
srs-docker-install:
	ansible-playbook -i $(HOSTS_INI_FILE) $(SRS_ROOT_DIR)/docker.yml --tags install \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)
srs-docker-uninstall:
	ansible-playbook -i $(HOSTS_INI_FILE) $(SRS_ROOT_DIR)/docker.yml --tags uninstall \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

srs-router-install:
	ansible-playbook -i $(HOSTS_INI_FILE) $(SRS_ROOT_DIR)/router.yml --tags install \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)
srs-router-uninstall:
	ansible-playbook -i $(HOSTS_INI_FILE) $(SRS_ROOT_DIR)/router.yml --tags uninstall \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

srs-gnb-start:
	ansible-playbook -i $(HOSTS_INI_FILE) $(SRS_ROOT_DIR)/gNb.yml --tags start \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)
srs-gnb-stop:
	ansible-playbook -i $(HOSTS_INI_FILE) $(SRS_ROOT_DIR)/gNb.yml --tags stop \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

srs-uesim-start:
	ansible-playbook -i $(HOSTS_INI_FILE) $(SRS_ROOT_DIR)/uEsimulator.yml --tags start \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)
srs-uesim-stop:
	ansible-playbook -i $(HOSTS_INI_FILE) $(SRS_ROOT_DIR)/uEsimulator.yml --tags stop \
		--extra-vars "ROOT_DIR=$(ROOT_DIR)" --extra-vars $(EXTRA_VARS)

# run srs-docker-install before running setup
srs-gnb-install: srs-router-install srs-gnb-start
srs-gnb-uninstall:  srs-gnb-stop srs-router-uninstall

