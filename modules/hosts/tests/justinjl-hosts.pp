class { '::hosts' :
    file        => '/etc/hosts',
    owner       => 'root',
    group       => 'root',
    mode        => '0644',
    localhost   => true,
    primary     => true,
    purge       => true,
}

::hosts::add { '172.16.0.251' :
    fqdn        => 'puppet.mydomain.com',
    aliases     => [ 'puppet' ]
}
