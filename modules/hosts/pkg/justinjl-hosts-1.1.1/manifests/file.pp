################################################################################
#
# Class: hosts::file
#
# This class declares the file and empties its content if $purge is set.
#
################################################################################
class hosts::file {

    file { $hosts::hostsfile :
        owner   => $hosts::owner,
        group   => $hosts::group,
        mode    => $hosts::mode,
    }

    if ( $hosts::purge == true ) {
        resources { 'host' :
            purge   => true
        }
    }

}

