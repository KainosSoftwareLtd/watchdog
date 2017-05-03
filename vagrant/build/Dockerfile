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
  rubygems \
  scl-utils \
  centos-release-scl-rh

RUN yum install zlib-devel -y

RUN yum install -y ruby193 ruby193-ruby-devel python27

RUN scl enable ruby193 "gem install gauntlt --no-ri --no-rdoc"

# Install additional third-party tools

#Setup sslyze
RUN cd /tmp && wget -nv https://github.com/nabla-c0d3/sslyze/releases/download/0.12.0/sslyze-0_12-linux64.zip && \
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
    cd Garmr && scl enable python27 "python setup.py install" && \
    scl enable python27 "pip install BeautifulSoup"

# Install JSON Gem as SCL means this isn't available in the restricted runtime environment
RUN scl enable ruby193 "gem install json -v 1.8.3 --no-ri --no-rdoc"

# Remove unnecessary packages
RUN yum remove -y unzip \
    wget \
    git
RUN rm -rf /tmp/*

VOLUME ["/data"]

WORKDIR /data

# Expose path so it is able to reference sqlmap/sslyze
# The inclusion of the additional rubvy path value is required for referencing gems installed via SCL ruby
ENV PATH /usr/local/bin:/opt/arachni/bin:/opt/rh/ruby193/root/usr/local/bin:$PATH

ENV SSLYZE_PATH /usr/local/bin/sslyze

CMD bash -c 'scl enable ruby193 python27 "gauntlt -f progress"'
