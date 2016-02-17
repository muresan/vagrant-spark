################################################################################
#
# Class: hosts::localhost
#
# This class adds localhost entries (ipv4, optionally ipv6) to the hosts file
#
################################################################################
class hosts::localhost {

    # Do not add localhost entries if they have been disabled
    unless ( $hosts::localhost == false ) {

        # Create entry for localhost
        ::hosts::add { '127.0.0.1' :
            fqdn    => 'localhost.localdomain',
            aliases => 'localhost',
        }

        # Create entries for ipv6 localhost
        ::hosts::add { '::1' :
            fqdn    => 'localhost.localdomain',
            aliases => [ 'localhost', 'ip6-localhost', 'ip6-loopback' ],
        }
        ::hosts::add { 'fe00::0' :
            fqdn    => 'ip6-localnet',
        }
        ::hosts::add { 'ff00::0' :
            fqdn    => 'ip6-mcastprefix',
        }
        ::hosts::add { 'ff02::1' :
            fqdn    => 'ip6-allnodes',
        }
        ::hosts::add { 'ff02::2' :
            fqdn    => 'ip6-allrouters',
        }

    }

}

