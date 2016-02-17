define hosts::add (
    $fqdn,
    $ipaddr = $name,
    $aliases = undef,
) {

    # Assembling the line for the hosts file.
    if is_array( $aliases ) {

        # $aliases is an array. Convert to space separated string.
        $line = sprintf( '%-15s %s %s', $ipaddr, $fqdn, join( $aliases, ' ' ) )

    } elsif is_string ( $aliases ) {

        # $aliases is a string. Include it in the line.
        $line = sprintf( '%-15s %s %s', $ipaddr, $fqdn, $aliases )

    } else {

        # $aliases is undefined. Leave it out.
        $line = sprintf( '%-15s %s', $ipaddr, $fqdn )

    }

    # Write the line to hosts file
    file_line { $ipaddr :
        ensure  => 'present',
        path    => $hosts::hostsfile,
        line    => $line,
        match   => "^${ipaddr}[ \t]",
    }

}
