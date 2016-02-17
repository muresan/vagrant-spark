
$master_hostname = '192.168.124.101'

package { "vim-enhanced": ensure => 'installed', }
package { "git"         : ensure => 'installed', }
package { "acpid"       : ensure => 'installed', }
package { "nss"         : ensure => 'latest',    }
package { "java-1.8.0-openjdk": ensure => 'installed', }

class {'::hosts': }
::hosts::add { '192.168.124.101' : fqdn => 'sparkm.example.com' }
::hosts::add { '192.168.124.201' : fqdn => 'spark1.example.com' }
::hosts::add { '192.168.124.202' : fqdn => 'spark2.example.com' }
::hosts::add { '192.168.124.203' : fqdn => 'spark3.example.com' }
::hosts::add { '192.168.124.150' : fqdn => 'jenkins.example.com' }


node /^sparkm/ {

  yumrepo { 'cloudera-cdh5':
    ensure   => present,
    baseurl  => 'https://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/5/',
    gpgkey   => 'https://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera',
    enabled  => true,
    gpgcheck => 1,
    descr    => 'Cloudera\'s Distribution for Hadoop, Version 5',
  }

  class {'hadoop':
    realm         => '',
    hdfs_hostname => $master_hostname,
    slaves        => ['spark1.example.com', 'spark2.example.com', 'spark3.example.com'],
    require       => Yumrepo['cloudera-cdh5'],
  }

  class {'spark':
    master_hostname        => $master_hostname,
    hdfs_hostname          => $master_hostname,
    historyserver_hostname => $master_hostname,
    yarn_enable            => false,
    environment            => {
      'SPARK_LOCAL_IP' => $::ipaddress_eth1,
    },
    require       => Yumrepo['cloudera-cdh5'],
  }

  include spark::master
  include spark::historyserver
  include hadoop::namenode
  include spark::hdfs
}


node /^spark\d+/ {

  yumrepo { 'cloudera-cdh5':
    ensure   => present,
    baseurl  => 'https://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/5/',
    gpgkey   => 'https://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera',
    enabled  => true,
    gpgcheck => 1,
    descr    => 'Cloudera\'s Distribution for Hadoop, Version 5',
  }     

  class {'hadoop':
    realm         => '',
    hdfs_hostname => $master_hostname,
    slaves        => ['spark1.example.com', 'spark2.example.com', 'spark3.example.com'],
    require       => Yumrepo['cloudera-cdh5'],
  }     

  class {'spark':
    master_hostname        => $master_hostname,
    hdfs_hostname          => $master_hostname,
    historyserver_hostname => $master_hostname,
    yarn_enable            => false,
    environment            => {  
      'SPARK_LOCAL_IP' => $::ipaddress_eth1,
    },    
    require       => Yumrepo['cloudera-cdh5'],
  }     

  include spark::worker
  include hadoop::datanode
}

node /^jenkins$/ {
  class { 'jenkins': }
  # plugin and dependencies
  jenkins::plugin { ['git','git-client','ssh-credentials','promoted-builds','parameterized-trigger','token-macro','scm-api']: }
  # plugin and dependencies
  jenkins::plugin { 'slack': }
  jenkins::plugin { ['puppet','deployment-notification']: }
  jenkins::plugin { ['github','github-api','plain-credentials']: }

}
