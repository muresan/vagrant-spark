################################################################################
#
# Class: hosts::header
#
# This class addes a managed by puppet header to the hosts file
#
################################################################################
class hosts::header {

    # header to be added to top of hosts file
    $header = '# This file is managed by puppet module ::hosts'

    # sed hax to add the header
    $command    = "sed -i '1s/^/${header}\\n/' '${hosts::hostsfile}'"

    # simple grep to check if header already exists
    $unless     = "grep '${header}' '${hosts::hostsfile}'"

    notice("file   : ${hosts::hostsfile}")
    notice("header : ${header}")
    notice("command: ${command}")
    notice("unless : ${unless}")

    # exec to add the header
    exec { 'hosts::header-insert_header' :
        path        => [ '/usr/bin', '/bin' ],
        command     => $command,
        unless      => $unless,
        refreshonly => false,
    }

    # And we need a file_line to ensure puppet doesn't remove the header
    file_line { 'hosts::header-header' :
        ensure  => 'present',
        path    => $hosts::hostsfile,
        line    => $header,
    }

}

