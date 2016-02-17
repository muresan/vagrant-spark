################################################################################
#
# Class: hosts::primary
#
# This class creates hosts file entry for facts ::fqdn and ::hostname, both
# resolving to fact ::ipaddress.
#
################################################################################
class hosts::primary {

    # do not add primary interface entries if that have been disabled
    unless ( $hosts::primary == false ) {

        # Create entry for localhost
        ::hosts::add { $::ipaddress :
            fqdn    => $::fqdn,
            aliases => $::hostname,
        }

    }

}
