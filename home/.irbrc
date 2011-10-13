unless defined? ETC_IRBRC_LOADED
  require 'rubygems'
  
  begin # load optional gems
    require 'interactive_editor'
  
    # Wirble gives us tab-completion, history, color, and other goodies.
    # http://pablotron.org/software/wirble/README
    require 'wirble'
    Wirble.init
    Wirble.colorize

  rescue LoadError
    puts "You didn't install interactive_editor and wirble! No biggie..."
  end
  
  puts "Wouldn't you rather be using pry?"
  
  ETC_IRBRC_LOADED=true
end
