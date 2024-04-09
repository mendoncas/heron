# Heron, a pull-based deployer!
This project aims to mimic the behavior of pull-based deployers like ArgoCD. 
The intended goal is to have a small program that, given a certain git repository, provisions minimal infrastructure to deploy the project 
and constantly watches over the repo, identifying and applying changes.

Needless to day, this is an experimental project that im using for practice.

## How it works 
The service is dependent on a simple shell script that constantly polls a given
git repository and applies the changes on the application when necessary
The script assumes that the application has a working Dockerfile from wich it can build a Docker image

The Ansible script configures the host machine with dependencies (mainly Docker) and runs the script as a systemd service.
This way, the script runs as a daemon and persists after the host is restarted. Also, the logs are easily tracked with journalctl.