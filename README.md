# Watchdog

## Description
This repository is intended to automate security/assurance testing for web services.

The intention is that we use docker on our continuous integration server to launch a container running gauntlt; to this we would pass in a sequence of tests to be executed against the web service (./attacks) where the observed results would be compared against the expected results.

This enables security to be audited over time and automates the execution of tests.

## Why Docker?
Docker enables us to have an immutable way of deploying an isolated 'environment' comprising of all of the security tools that Gauntlt can leverage without having to install them natively on the continuous integration server or its agents.

As docker relies upon images this repository gives us both a way of generating a new image - containing all required security tooling - and executing the pre-existing image.

### Build Node
This vagrant node is intended to build the docker image using the dockerfile in vagrant/build; this can then be used to update the hub image @ moomzni/gauntlt.  When you 'vagrant up build' the provisioner will automatically install docker and begin the build process for docker image.

### Run Node
This vagrant node downloads the latest version of the moomzni/gauntlt image from the docker hub and makes it available for running. When you 'vagrant up run' the provisioner will automatically install docker and download the image for moomzni/gauntlt from the docker hub.

To run the image you can do the following:

 - vagrant ssh run
 - sudo -i
 - docker run --rm -it -e "GAUNTLT_ATTACK_SUBJECT=www.google.com" -v /attacks:/data moomzni/gauntlt
  - You should replace 'www.google.com' with your intended attack subject

## Running on CI
So as we're running docker images we need to make sure that docker is installed and available on the CI server and its agents; if using Centos the EPEL repository contains a docker-io package.

The invocation of the docker containers will require sudo access; this may or may not require changes to your existing CI sudoers rules depending on how liberal/restricted your current setup is.

We need to make the ./attacks folder available to the docker container at runtime so gauntlt executes the tests we expect.  To do this we simply have a to determine the absolute path for the git checkout directory and mount the 'attacks/' folder within the container as follows: -v <YOUR ABSOLUTE PATH HERE>/attacks:/data

Some other considerations are listed below:

 - The '-i' option cannot be used within a CI job as - by its nature - it is not an interactive process
 - The '--rm' flag should be specified to ensure images are removed/deleted once they have completed processing.


## Caveats

 - Currently only supports Centos
 - Has only been tested with Centos 6.6
 - Has currently only been tested with TeamCity v9.0
