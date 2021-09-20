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
- [python3.8](https://www.python.org)

Visit the sites for installation instructions.

## Up and running

1. Create python virtual environment and activate it:
   ```bash
   python3.8 -m venv .venv
   source .venv/bin/activate
   ```
2. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ansible-galaxy install --roles-path ansible/roles --role-file ansible/requirements.yml
   ```
3. Get jenkins nodes up and running:
   ```bash
   vagrant up
   ```
4. Set up pipeline using JJB:
   ```bash
   jenkins-jobs --conf jenkins-job-builder/config.ini --server jenkins-master update jenkins-job-builder/pipeline.yml
   ```
5. Manually add jenkins' slaves: login using these credentials
   ```
   user: admin
   password: admin
   ```
   to the page http://127.0.0.1:8080/computer/new and add two slaves:
   - windows-slave
   - linux-slave

   Then run agents on each node:
   ```
   vagrant ssh slave1
   sudo run-jenkins-agent.sh
   ```
   ```
   vagrant ssh slave2
   powershell.exe  C:\Users\vagrant\run-jenkins-agent.ps1
   ```
6. At this point the environment will be ready and you will be able to use the pipeline: http://127.0.0.1:8080/job/test_job/ 
   
# TODO
- automatic configuration of slaves
- implement gathering of system parameters from the slaves using Groovy/Java
- implement: 
  1. A git commit to some project triggers in parallel:
  - a job on a windows host
  - a job on a linux host
  2. Also, a user should be able to trigger the same workflow and have options to specify:
  - platform: windows, linux or both.
  - git branch or tag
