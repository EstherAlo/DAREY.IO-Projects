# __CONTINOUS INTERGRATION PIPELINE FOR TOOLING WEBSITE__

## Install Jenkins server

I created an AWS EC2 server based on Ubuntu Server 20.04 LTS and name it "Jenkins". Following this I installed JDK and Jenkins and ensured it was up and running:

*Screenshot below*

Jenkins default server TCP port 8080 so a new Inbound Rule was created within my EC2 Security Group

*Screenshot below*

I accessed Jenkins via my browser and was prompted to provide a default admin password. I retrieved this by running this command:

```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Following this suggested plugins were installed and an admin user was created.

## Configure Jenkins to retrieve source codes from GitHub using Webhooks

Here configured a simple Jenkins job. This job will will be triggered by GitHub webhooks and was executed a ‘build’ task to retrieve codes from GitHub and store it locally on Jenkins server.

I enabled webhooks in my GitHub repository settings, after this I created a freestyle project in the Jenkins console. In configuration of my Jenkins freestyle project I inserted the  link to my Tooling GitHub repository and credentials so Jenkins could access files in the repository.

I saved the configuration and run the build manually - this was successful

*Screenshot below*

In order build to run automatically I added the below configurations 

*Screenshot below*
