################################################################################
#
# Class: hosts::file
#
# This class declares the file and empties its content if $purge is set.
#
################################################################################
class hosts::file {

    # set $content to '' to purge the file
    if ( $hosts::purge == true ) {
        $content = ''
    } else {
        $content = undef
    }

    # Declare the file
    file { $hosts::hostsfile :
        ensure  => 'present',
        content => $content,
        owner   => $hosts::owner,
        group   => $hosts::group,
        mode    => $hosts::mode,
    }

}

