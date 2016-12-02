require 'puppet/face'

Puppet::Face.define(:tp, '0.0.1') do
  copyright "Example 42", 2014
  license   "Apache 2 license; see COPYING"

  summary "Tiny Puppet commands."

  description <<-TEXT
    Run tp commands to interact with tp managed applications

    install - Install any application with tp (relevant tinydata must exist)

    Not yet Available tp commands:
    check - Check the status of the managed resources
    info - Show info, whatever info, related to managed applications
    log - Tail logs related to the application
  TEXT

  action :check do
    summary "Check the status of tp managed resources."

    description <<-TEXT
      Run checks
    TEXT

    when_invoked do |app, options|

      exec ( "/etc/tp/test/" + app )

    end
  end

  action :info do
    summary "Show information about tp managed applications."
    option("--[no-]verbose") do
      summary "Whether or not print more verbose output"
    end

    when_invoked do |app, options|

      exec ( "/etc/tp/info/" + app )

    end
  end

  action :log do
    summary "Tail all the logs relevant to an application."
    when_invoked do |app, options|

      exec ( "tp log " + app )

    end
  end

  action :install do
    summary "Install any application on any OS (if tinydata available)."
    when_invoked do |app, options|

      exec ( "puppet apply -t -e 'tp::install { " + app + ": auto_prerequisites => true }'")

    end
  end
end
