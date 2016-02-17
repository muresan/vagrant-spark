################################################################################
#
# Class: hosts::file
#
# This class declares the file and empties its content if $purge is set.
#
################################################################################
class hosts::file {

    if ( $hosts::purge == true ) {
        resources { 'host' :
            purge   => true
        }
    }

}

