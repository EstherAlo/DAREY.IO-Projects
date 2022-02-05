# __ANSIBLE REFACTORING AND STATIC ASSIGNMENTS (IMPORTS AND ROLES)__

In this project I continued working with my ansible-config-mgt repository and made some improvements to my code. 
I refactored the Ansible code, created assignments, and used the imports functionality. Imports allow to effectively re-use previously created playbooks in a new playbook – it allows you to organize your tasks and reuse them when needed.

*screenshot of Ansible architecture*



## Jenkins job enhancement

 - New change in the codes creates a separate directory which is not very convenient when we want to run some commands from one place. This consumes space on Jenkins serves with each subsequent change.


- Created  a new directory called ansible-config-artifact –  all artifacts will be stored here after each build.

```
sudo mkdir /home/ubuntu/ansible-config-artifact
```

Changed permissions to this directory, so Jenkins could save files there

```
chmod -R 0777 /home/ubuntu/ansible-config-artifact
```

went to the Jenkins web console -> Manage Jenkins -> Manage Plugins -> on Available tab search for Copy Artifact and installed this plugin without restarting Jenkins

*screenshot below* 

- Created a new Freestyle project and named it save_artifacts. This project will be triggered by completion of the existing ansible project. 

*screenshot below* 2

- The main idea of save_artifacts project is to save artifacts into /home/ubuntu/ansible-config-artifact directory. To achieve this, create a Build step and choose Copy artifacts from other project, specify ansible as a source project and /home/ubuntu/ansible-config-artifact as a target directory.

- Tested my set up by making some change in README.MD file inside the ansible-config repository (right inside master branch).

*screenshot showing build was made in saved_artifacts*

## Refactor Ansible Code By Importing Other Playbooks Into site.yml

- Within playbooks folder, I created a new file and named it site.yml – This file will now be considered as an entry point into the entire infrastructure configuration. Other playbooks will be included here as a reference. site.yml will become a parent to all other playbooks that will be developed.

- Created a new folder in root of the repository and named it static-assignments. The static-assignments folder is where all other children playbooks will be stored. This is merely for easy organization of my work. 

- The code below uses built in import_playbook Ansible module. This code was placed in the sites.yml file and tell ansible to to import from static assignment/common.yml file

```
---
- hosts: all
- import_playbook: ../static-assignments/common.yml
```

This what the  folder structure looks like:

*screenshot below*

updated site.yml with - import_playbook: ../static-assignments/common-del.yml instead of common.yml and run it against dev servers:

```
sudo ansible-playbook -i /home/ubuntu/ansible-config-artifact/inventory/dev.yml /home/ubuntu/ansible-config-artifact/playbooks/site.yml
```