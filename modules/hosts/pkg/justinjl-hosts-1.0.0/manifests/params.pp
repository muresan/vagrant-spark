################################################################################
#
# Class: hosts::params
#
# Default values for justinjl-hosts
#
################################################################################
class hosts::params {

    # Hosts file ownership/permissions
    $owner  = 'root'
    $group  = 'root'
    $mode   = '0644'

    # Default options
    $purge      = false
    $localhost  = true
    $primary    = true

    # Determine default file path based on OS
    case $::osfamily {

        'Debian','RedHat': {
            $hostsfile   = '/etc/hosts'
        }

        'windows':  {
            fail("Error: unsupported operating system.")
        }
    
        default:    {
            fail("Error: unsupported operating system. Please provide path to hosts file")
        }

    }

}

