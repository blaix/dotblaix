unless defined? ETC_IRBRC_LOADED
  require 'rubygems'
  require 'interactive_editor'
  
  # Wirble gives us tab-completion, history, color, and other goodies.
  # http://pablotron.org/software/wirble/README
  require 'wirble'
  Wirble.init
  Wirble.colorize
  
  ETC_IRBRC_LOADED=true
end
