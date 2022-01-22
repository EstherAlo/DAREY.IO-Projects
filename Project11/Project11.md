# __ANSIBLE AUTOMATION PROJECT__

## INSTALL AND CONFIGURE ANSIBLE ON EC2 INSTANCE

Ansible was installed unto my Jenkins server and Ansible version was checked

*screenshot below*

- Created a new Freestyle project ansible in Jenkins and pointed it to my‘ansible-config-mgt’ repository.
- Configured a Post-build job to save all (**) files
- Created a new repository in Github, named it ansible-config-mgt 
Configured Webhook and set webhook to trigger ansible build.
