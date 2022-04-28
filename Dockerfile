FROM summerwind/actions-runner:latest

# for kubectl
RUN curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - \
	&& sudo touch /etc/apt/sources.list.d/kubernetes.list \
	&& echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

# for git-lfs
RUN curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | sudo bash

RUN sudo apt update -y \
	&& sudo apt-get install -y --no-install-recommends \
	python3.8-venv \
	kubectl \
	git-lfs \
	&& sudo rm -rf /var/lib/apt/lists/*

RUN wget -O /tmp/awscli-bundle.zip https://s3.amazonaws.com/aws-cli/awscli-bundle.zip \
	&& unzip -qq /tmp/awscli-bundle.zip -d /tmp \
	&& sudo python3 /tmp/awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws \
  && rm -rf /tmp/awscli-bundle
