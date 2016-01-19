FROM centos:6.6

MAINTAINER Caoimhin Graham <c.graham@kainos.com>

# Install base packages
RUN yum makecache && yum install -y curl \
  nmap \
  wget \
  unzip \
  tar  \
  nmap \
  curl \
  git \
  gcc \
  which \
  ruby-devel \
  rubygems

# Install RVM and switch to Ruby 1.9.3 as default and install gauntlt
RUN cd /tmp && gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
  curl -sSL https://get.rvm.io | bash -s stable && \
  bash -c "source /etc/profile.d/rvm.sh && rvm install 1.9.3 && rvm default 1.9.3 && ruby -v && gem install gauntlt --no-ri --no-rdoc"

# Install Python 2.7 as it is required by some of the third party tools
RUN cd /tmp && wget -nv https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tgz && \
    tar xzf Python-2.7.11.tgz && \
    cd Python-2.7.11 && ./configure && make altinstall && make bininstall

# Install Python setuptools and pip
RUN wget -nv https://bootstrap.pypa.io/ez_setup.py -O - | python && \
    easy_install-2.7 pip

# Install additional third-party tools

#Setup sslyze
RUN cd /tmp && wget -nv https://github.com/nabla-c0d3/sslyze/releases/download/release-0.12/sslyze-0_12-linux64.zip && \
  unzip sslyze-0_12-linux64.zip && rm -f sslyze-0_12-linux64.zip && \
  mv sslyze /opt && \
  ln -s /opt/sslyze/sslyze.py /usr/local/bin/sslyze

# Instal SQLMap
RUN cd /tmp && wget -nv https://github.com/sqlmapproject/sqlmap/archive/0.6.2.tar.gz && \
  tar xf 0.6.2.tar.gz && \
  mv sqlmap-0.6.2 /opt/sqlmap && \
  ln -s /opt/sqlmap/sqlmap.py /usr/local/bin/sqlmap

# Install Arachni
RUN cd /tmp && wget -nv https://www.github.com/Arachni/arachni/releases/download/v1.3.2/arachni-1.3.2-0.5.9-linux-x86_64.tar.gz && \
    tar xzf arachni-1.3.2-0.5.9-linux-x86_64.tar.gz && \
    mv arachni-1.3.2-0.5.9 /opt/arachni

# Install Garmr
RUN cd /opt && git clone https://github.com/freddyb/Garmr.git && \
    cd Garmr && python setup.py install && \
    pip install BeautifulSoup

# Remove unnecessary packages
RUN yum remove -y unzip \
    wget \
    git
RUN rm -rf /tmp/*

VOLUME ["/data"]

WORKDIR /data

# Expose path so it is able to reference sqlmap/sslyze
ENV PATH /usr/local/bin:/opt/arachni/bin:$PATH

ENV SSLYZE_PATH /usr/local/bin/sslyze

CMD bash -c 'source /etc/profile.d/rvm.sh && gauntlt -f progress'
