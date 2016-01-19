# Watchdog

## Description
This repository is intended to automate security/assurance testing for Rural Payments environments.

The idea is that we use docker on teamcity to launch a container running gauntlt; to this we would pass in a sequence of tests to be executed against the environments (./attacks) where the observed results would be compared against the expected results.

This enables security to be audited over time and automates the execution of tests.

## Why Docker?
Docker enables us to have an immutable way of deploying an isolated 'environment' comprising of all of the security tools that Gauntlt can leveridge without having to install them natively on the teamcity/agent servers.

As docker relies upon images this repository gives us both a way of generating a new image - containing all required security tooling - and executing the pre-existing image.

### Build Node
This vagrant node is intended to build the docker image using the dockerfile in vagrant/build; this can then be used to update the hub image @ moomzni/gauntlt.  When you 'vagrant up build' the provisioner will automatically install docker and begin the build process for the moomzni/gauntlt docker image.

To upload the image to docker hub you can do the following:

 - vagrant ssh build
 - sudo -i
 - docker login (enter your details)
 - docker push moomzni/gauntlt
 - docker logout

### Run Node
This vagrant node downloads the latest version of the moomzni/gauntlt image from the docker hub and makes it available for running. When you 'vagrant up run' the provisioner will automatically install docker and download the image for moomzni/gauntlt from the docker hub.

To run the image you can do the following:

 - vagrant ssh run
 - sudo -i
 - docker run --rm -it -e "GAUNTLT_ATTACK_SUBJECT=www.google.com" -v /attacks:/data moomzni/gauntlt
  - You should replace 'www.google.com' with your intended attack subject

## Teamcity Integration
Both Teamcity and the agent servers have docker installed via puppet (docker-io package from EPEL); the agents already have sudo access so the invocation of any docker command by an agent simply needs to be preceeded by sudo e.g. sudo docker ps -a.

We need to mount the gauntlt tests we want to execute within the docker container.  To do this we simply have a VCS root setup on Teamcity to checkout this repository and mount the 'attacks/' folder within the container as follows: -v -v %teamcity.build.checkoutDir%/attacks:/data

Some other considerations are listed below:

 - The '-i' option cannot be used within a teamcity job as by its nature it is not an interactive job
 - The '--rm' flag should be specified to ensure images are removed/deleted once they have completed processing.


## Comments
[DS] This is a good idea! Some things to consider and maybe ellaborate a bit more about it could be:
* Housekeeping of the containers -  creating, starting, stopping and removing [CG] - Answered
* Image distribuiton - where do we build, save and share [CG] - Answered
* Any networking considerations we need to take into account to have the contained gauntlt instance reaching all the envs [CG] - Answered
* If using data volumes lets make sure they are housekept following the same guidelines we'll be using for containers [CG] - Answered
* Is the intention to run gauntlt continuously i.e. triggering a build after event x? if yes we should have consensus on what kind of attacks we'll be allowing during office hours and/or while validation testing is in progress

[MS] As long as I'm fine with this, I can't see any cons of installing gauntlt gem instead of using docker? Especially, just for one 'service'. [CG] This isn't just the gauntlt gem, it is all of the tooling that it leveridges underneath.

