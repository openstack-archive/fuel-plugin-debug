notice('MODULAR: run_override.pp')

file { '/etc/fuel/plugins/debug_plugin-1.0/debug_plugin.rb':
 ensure  => 'file',
 }
exec { "/usr/bin/ruby /etc/fuel/plugins/debug_plugin-1.0/debug_plugin.rb":
 require => File['/etc/fuel/plugins/debug_plugin-1.0/debug_plugin.rb'],
 }
