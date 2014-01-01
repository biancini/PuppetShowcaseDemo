import 'apache_httpd.pp'

node 'windowsclient.local','linuxclient.local' {
	class { 'apache_httpd' :

	}

}
