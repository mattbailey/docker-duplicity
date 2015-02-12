FROM google/python
MAINTAINER Matt Bailey <m@mdb.io>

# Data to backup
VOLUME /data

# Working directory
RUN mkdir -p /duplicity
WORKDIR /duplicity

# Add requirements
ADD requirements.txt /duplicity/requirements.txt

# Install librsync-dev
RUN apt-get -y install librsync-dev

# Install python requirements
RUN pip install --upgrade --requirement /duplicity/requirements.txt

# Get duplicity
ADD https://code.launchpad.net/duplicity/0.7-series/0.7.01/+download/duplicity-0.7.01.tar.gz /tmp/duplicity.tgz

# Extract & Build
RUN tar -xzf /tmp/duplicity.tgz --strip-components 1 && ./setup.py install

# Set the ENTRYPOINT
ENTRYPOINT [ "/usr/local/bin/duplicity" ]
