FROM centos

# RUN apt-get update
# RUN apt-get install -y python
# RUN apt-get install -y python-pip
# RUN apt-get -y install db5.3-util
# RUN apt-get -y install libssl-dev libbz2-dev libmcpp-dev libdb++-dev libdb-dev
# RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 5E6DA83306132997
# RUN apt-get -y install lsb-release
# RUN apt-get -y install software-properties-common
# RUN apt-add-repository "deb http://zeroc.com/download/apt/ubuntu`lsb_release -rs` stable main"
# RUN apt-get update
# RUN apt-get -y install zeroc-ice-all-# RUNtime zeroc-ice-all-dev python-zeroc-ice
# RUN apt-get -y install curl unzip

RUN yum -y install epel-release
RUN yum -y install unzip curl bc
RUN yum -y install java-1.8.0-openjdk
RUN yum -y install \
	python-pip python-devel python-virtualenv \
	python-yaml python-jinja2 \
	python-pillow numpy scipy python-tables
RUN pip install --upgrade pip

RUN curl -L -o /etc/yum.repos.d/zeroc-ice-el7.repo https://zeroc.com/download/rpm/zeroc-ice-el7.repo
RUN yum -y install gcc-c++
RUN yum -y install libdb-utils
RUN yum -y install openssl-devel bzip2-devel expat-devel
RUN yum -y install ice-all-runtime ice-all-devel
RUN pip install "zeroc-ice>3.5,<3.7"

WORKDIR /opt/omero
# RUN curl -L -O https://downloads.openmicroscopy.org/omero/5.3.3/artifacts/OMERO.py-5.3.3-ice36-b63.zip
RUN curl -L -O https://downloads.openmicroscopy.org/omero/5.2.8/artifacts/OMERO.py-5.2.8-ice36-b57.zip
RUN unzip *.zip && rm *.zip
RUN ln -s OMERO.py* OMERO.py

ENV OMERO_PREFIX /opt/omero/OMERO.py
ENV PYTHONPATH $PYTHONPATH:/opt/omero/OMERO.py/lib/python
