FROM centos:latest
MAINTAINER deepak

RUN yum -y update
RUN yum -y install gcc
RUN yum -y install git
RUN yum -y install python-devel
RUN yum -y install python-setuptools yum
RUN yum -y install --enablerepo=centosplus openssl-devel
RUN easy_install pip
RUN pip install paramiko PyYAML jinja2 httplib2
RUN curl https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py | python
RUN pip install ansible
RUN mkdir -p /etc/ansible
RUN mkdir -p /etc/ansible_downloads && cd /etc/ansible_downloads && git clone http://git/opensource//ansible_playbooks.git && cd /etc/ansible_downloads/ansible_playbooks/ && git pull
RUN rm /etc/playbook.yml && /bin/echo -e '---' >> /etc/playbook.yml && /bin/echo -e '- hosts: all' >> /etc/playbook.yml && /bin/echo -e ' roles:' >> /etc/playbook.yml
RUN cd /etc/ansible_downloads/ansible_playbooks && /bin/echo -e \" - mysql\" >> /etc/playbook.yml && /bin/echo -e \" - java\" >> /etc/playbook.yml && /bin/echo -e \" - node\" >> /etc/playbook.yml && /bin/echo -e \" - ember-cli\" >> /etc/playbook.yml && cp /etc/playbook.yml /etc/ansible_downloads/ansible_playbooks/ && cd /etc/ansible_downloads/ansible_playbooks && ansible-playbook playbook.yml -c local -vvvv --extra-vars='nvm_version=0.10.28 npm_executable=/etc/ansible_downloads/nvm/v0.10.28/bin/npm executable=/bin/bash java_version=1.7.0_25 pkg_dir=/etc/ansible_downloads/'
RUN rm -f /etc/ansible_playbooks.yml && rm -rf /ansible_playbooks && git clone http://git/opensource/ansible_playbooks.git && cd /ansible_playbooks && git pull
RUN /bin/echo -e \"---\" > /etc/playbook.yml && /bin/echo -e \"- hosts: all\" >> /etc/playbook.yml && /bin/echo -e \" roles:\" >> /etc/playbook.yml && /bin/echo -e \" - ant\" >> /etc/playbook.yml && cp /etc/playbook.yml /ansible_playbooks && cd /ansible_playbooks && ansible-playbook playbook.yml -c local -vvvv --extra-vars=\"ant_version=1.8.1 pkg_dir=/etc/ansible_downloads/\"
RUN npm install -g bower
