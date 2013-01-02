class jenkins::repo ( $lts = 0, $repo = 1 )
	{
  # JJM These anchors work around #8040
  anchor { 'jenkins::repo::alpha': }
  anchor { 'jenkins::repo::omega': }
  notify {"Repos with \$lts ${lts} .  \$repo ${repo} ":}
  
  if $repo == 1 {
	  case $::osfamily {
	    'RedHat': {
	      class { 'jenkins::repo::el':
			lts  => $lts,
	        require => Anchor['jenkins::repo::alpha'],
	        before  => Anchor['jenkins::repo::omega'],
	      }
	    }
	    'Debian': {
	      class { 'jenkins::repo::debian':
			lts  => $lts,
		    require => Anchor['jenkins::repo::alpha'],
	        before  => Anchor['jenkins::repo::omega'],
	      }
	    }

	    default: {
	      fail( "Unsupported OS family: ${::osfamily}" )
	    }
	  }
  }
}

