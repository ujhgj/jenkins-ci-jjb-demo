# Jenkins CI + JJB (Vagrant demo)

## Description
This repo implements Continuous Integration demo for sample project.

Environment:
Jenkins master + 2 slaves:
   - Linux
   - Windows

Environment is configured using Infrastructure as Code approach with Vagrant and Ansible.

## Prerequisites

You must have this software installed and configured:
- [Vagrant](https://www.vagrantup.com)
- [Virtualbox](https://www.virtualbox.org)
- [python3](https://www.python.org)

Visit the sites for installation instructions.

## Porject Up and Running

1. Create python virtual environment and activate it:
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   ```
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ansible-galaxy install --roles-path ansible/roles --role-file ansible/requirements.yml
   ```
3. Get jenkins nodes up and running (warning! good internet connection required):
   ```bash
   vagrant up
   ```

4. Run agents on each node:
   ```
   vagrant ssh slave1
   sudo run-jenkins-agent.sh
   ```
   ```
   vagrant ssh slave2
   powershell.exe C:\Users\vagrant\run-jenkins-agent.ps1
   ```

At this point you have Jenkins server and 2 slaves up and running. You can log into using credentials

   ```
   user: admin
   password: admin
   ```
   
5. Set up pipeline using JJB:
   ```bash
   jenkins-jobs --conf jenkins-job-builder/config.ini --server jenkins-master update jenkins-job-builder/pipeline.yml
   ```

6. Add credentials for ssh to git server (todo explanation).

7. Setup demo repo:
   ```
   git clone git@github.com:ujhgj/jenkins-ci-jjb-demo-application.git
   cd jenkins-ci-jjb-demo-application
   git remote add vagrant git@127.0.0.1:test.git
   ```
   
At this point you are able to push commit to git repository and build will be triggered (pollSCM trigger). For example:
```bash
echo test > test.txt
commit -am 'test'
GIT_SSH_COMMAND="ssh -p 2200" git push vagrant master
```
Visit http://127.0.0.1:8080/job/multibranch_variant/

# TODO
- automatic launch for slaves
- move admin:admin for ansible to group vars
- parametrize ssh keys for git server and automatically add credentials for pipeline
