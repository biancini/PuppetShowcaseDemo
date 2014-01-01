class apache_httpd {
	if ($::kernel == 'windows') {
		exec { 'mount sofware share':
			command => 'net.exe use S: \\pupmaster\software',
			logoutput => true,
			cwd => 'C:\\',
			path => ['C:\\WINDOWS\\system32'],
			unless => 'net.exe use S:',
		} ->

		package { 'installation of apache package':
			ensure => installed,
			source => 'S:\httpd-2.2.25-win32-x86-openssl-0.9.8y.msi',
			install_options => undef,
		} ->

		file_line { 'finalize apache configuration':
			path => 'C:/Programmi/Apache Software Foundation/Apache2.2/conf/httpd.conf',
			match => '^ServerAdmin',
			line => 'ServerAdmin admin@your-domain.com',
			ensure => present,
		} ~>

		exec { 'register apache service':
			command => 'httpd.exe -k install',
			logoutput => true,
			cwd => 'C:\\Programmi\\Apache Software Foundation\\Apache2.2\\bin',
			path => ['C:\\WINDOWS\\system32', 'C:\\Programmi\\Apache Software Foundation\\Apache2.2\\bin'],
			refreshonly => true,
		}

		service { 'Apache2.2':
			ensure => running,
			enable => true,
			require => File_Line['finalize apache configuration']
		}
	}
	else {
		class { 'apache': }

		apache::vhost { 'virtualhost':
			port => 80,
			docroot => '/var/www',
		}
	}

}
