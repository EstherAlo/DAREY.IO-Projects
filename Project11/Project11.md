# __ANSIBLE AUTOMATION PROJECT__

## INSTALL AND CONFIGURE ANSIBLE ON EC2 INSTANCE

Ansible was installed unto my Jenkins server and Ansible version was checked

*screenshot below*

- Created a new Freestyle project ansible in Jenkins and pointed it to my‘ansible-config-mgt’ repository.

*screenshot below*
- Configured a Post-build job to save all (**) files
- Created a new repository in Github, named it ansible-config-mgt 
Configured Webhook and set webhook to trigger ansible build.

Tested my setup by making some change in README.MD file in master branch and make sure that  builds starts automatically and that Jenkins saved the files (build artifacts) in following folder

```
ls /var/lib/jenkins/jobs/ansible/builds/<build_number>/archive/
```

*screenshot below*

### Prepare my development environment using Visual Studio Code

I configured an IDE (VCS) to connect to my ansible config respository

## BEGIN ANSIBLE DEVELOPMENT

The below command was executed within vcs in order to create a new branch that will be used for development of a new feature

```
git checkout -b prj-11
```

Created a 'playbooks' and 'inventory' directory and within the playbooks directory I created a playbook (common.yml). Within the inventory file I created a file for each development stage (Development, Staging Testing and Production)

### Set up an Ansible Inventory

 Ansible uses TCP port 22 by default, which means it needs to ssh into target servers from Jenkins-Ansible host  in order to achieve this I copied my private (.pem) key to my ansible/jenkins server

Imported my key into ssh-agent by executing the commands below:

```
eval `ssh-agent -s`

ssh-add <path-to-private-key>
```

Confirmed the key had been successfuly added with the following command:

ssh -A ubuntu@public-ip

To check that I was able to connect to my target servers I executed the following commands

```
ssh ec2-user@<privateipaddress>

ssh ubuntu@<privateipadress>
```