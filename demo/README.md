Puppet Demo
===========

Here all the Puppet configuration and the instructions to reproduce the demo showed during the Showcase are provided.

To replicate the demo showed during the Showcase you would need to perform the following operations:

* **Install and configure the Puppet Master**: these operations will show the steps needed to create a puppet master and install
  the sowfware used for the installation of the clients of this demo.

* **Install a Linux client and connect to the Puppet Master**: these operations will show the steps to configure a Puppet linux
  client to the puppet master installed in the previos step.

* **Install a Windows client and connect to the Puppet Master**: these operations will show the steps to configure a Puppet windows
  client to the puppet master installed in the previos step.

Installing Puppet Master
------------------------

In the following the procedure too install a server which will act as a Puppet master will be described.
This guide will presume you will install the Puppet master on a Linux server, as a reference we will use Ubuntu 12.04 (LTE).
The same steps, with the proper modifications, will permit to install the Puppet master also on different versions of Linux and even
on different Operating Systems, like Windows.

* Install the puppet master package. To install the puppet master software you can follow the instructions here:
  [installation of puppet master](http://projects.puppetlabs.com/projects/1/wiki/downloading_puppet).
  Assuming you are using Ubuntu you can install the puppet master using the command:
  ```
  # sudo apt-get install puppetmaster
  ``

* Install all the required additional puppet modules. The recipes created to install Apache httpd on Linux and on Windows will leverage
  existing puppet modules that can be easily installed. To install the needed modules execute the following commands:
  ```
  # sudo puppet module install puppetlabs/registry
  # sudo puppet module install reidmv/windows_package
  # sudo puppet module install simondean/net_share
  # sudo puppet module install puppetlabs/apache
  ```
  The first three modules installed will be used by the Windows part of the recipe, the latter instead will be used for Linux.
  If you are interested in having more information about these modules, please visit the following pages:
  * [puppetlabs/registry](https://forge.puppetlabs.com/puppetlabs/registry)
  * [reidmv/windows_package](https://forge.puppetlabs.com/reidmv/windows_package)
  * [simondean/net_share](https://forge.puppetlabs.com/simondean/net_share)
  * [puppetlabs/apache](https://forge.puppetlabs.com/puppetlabs/apache)

* Copy the files in ``puppet/manifests`` under the folder ``/etc/puppet/manifests`` and modify the file ``site.pp`` so that it contains
  the hostnames of the two client machines you will be installing.
  The current names currently provided are ``windowsclient.local`` and ``linuxclient.local`` and must be changed to match
  the actual names of the two clients.

* Restart the ``puppetmaster`` service, on Ubuntu you can do that by executing the following command:
  ``` sudo service puppetmaster restart```

Installing Linux client
-----------------------

aa

Installing Windows client
-------------------------

aa
