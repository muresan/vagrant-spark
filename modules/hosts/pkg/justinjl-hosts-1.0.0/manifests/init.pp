################################################################################
#
# Class: hosts
#
################################################################################
class hosts (
    $hostsfile  = $hosts::params::hostsfile,
    $owner      = $hosts::params::owner,
    $group      = $hosts::params::group,
    $mode       = $hosts::params::mode,
    $purge      = $hosts::params::purge,
    $localhost  = $hosts::params::localhost,
    $primary    = $hosts::params::primary,
) inherits hosts::params {

    anchor { '::hosts::begin' :     } ->
    class  { '::hosts::file' :      } ->
    class  { '::hosts::header' :    } ->
    class  { '::hosts::localhost' : } ->
    class  { '::hosts::primary' :   } ->
    anchor { '::hosts::end' :       }

}
