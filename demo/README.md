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

In the following the procedure to install a server which will act as a Puppet master will be described.
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
  root@puppetmaster:~# sudo puppet module install puppetlabs/registry
  root@puppetmaster:~# sudo puppet module install reidmv/windows_package
  root@puppetmaster:~# sudo puppet module install simondean/net_share
  root@puppetmaster:~# sudo puppet module install puppetlabs/apache
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
  ``` root@puppetmaster:~# service puppetmaster restart```

Installing Linux client
-----------------------

In the following the procedure to install a puppet client on a Linux server will be described.
This guide will presume you will install the Puppet master on a Linux server, as a reference we will use Ubuntu 12.04 (LTE).
The same steps, with the proper modifications, will permit to install the Puppet master also on different versions of Linux.

* Install the puppet package. To install the puppet master software you can follow the instructions here:
  <http://projects.puppetlabs.com/projects/1/wiki/downloading_puppet>.
  Assuming you are using Ubuntu you can install the puppet master using the command:
  ```
  root@linuxclient:~# sudo apt-get install puppet
  ``

* Modify the file ``/etc/puppet/puppet.conf`` adding the following section:
  > [agent]
  > server=puppetmaster.local
  > pluginsync=true

  These instruction will instruct the Puppet agent to:
  * Connect to the puppet master at the address ``puppetmaster.local``, you need to change this name to match the
    network name of the puppet master installet in the previous section. Attention it is important that the client
    server is able to contact the puppet master via the network using the name specified. To test this you can
    open a console and test that ``ping puppetmaster.local`` (or the name you specified in the ``puppet.conf`` file)
    will work correctly.
  * Download all additional plugins, modules and facts (if any) from the puppet master to be executed during
    the installation phase.

* Exchange certificates with puppet master to guarantee that a proper identification of servers is performed.
  This step is required for security reasons by the Puppet infrastructure. A more descriptive description of
  the usage of certificates inside Puppet can be found here:
  <http://projects.puppetlabs.com/projects/1/wiki/certificates_and_security>.
  To realize this certificate excange you need to perform the following operations on both the puppet client and
  the puppet master. On the client:
  ```
  root@linuxclient:~# puppet agent --test
  info: Creating a new SSL key for linuxclient.local
  info: Caching certificate for ca
  info: Creating a new SSL certificate request for linuxclient.local
  info: Certificate Request fingerprint (md5): 76:DA:A4:D2:A0:92:4E:94:7B:3F:34:B5:EF:F1:F0:29
  Exiting; no certificate found and waitforcert is disabled
  ```
  On the puppet master:
  ```
  root@puppetmaster:~# puppet cert sign --all
  ```

* Now you are finally ready to use puppet to intall apache httpd. You can do that by issuing the following
  command on the ``linuxclient`` machine:
  ```
  root@linuxclient:~# puppet agent --test
  ```
  The command should execute with no problems and at the end of the installation and configuration process you
  should be able to verify that apache has been installed (for instance by navigating with a browser to the
  web-page ``http://linuxclient.local/`` and seeing the familiar Apache welcome page).

Installing Windows client
-------------------------

aa
