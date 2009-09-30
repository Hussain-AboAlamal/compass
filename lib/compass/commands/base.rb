module Compass
  module Commands
    class Base
      def self.inherited(command_class)
        if command_class.respond_to? :name
          Compass::Commands[command_class.name] = command_class
        end
      end

      include Actions

      attr_accessor :working_path, :options

      def initialize(working_path, options)
        self.working_path = working_path
        self.options = options
      end
      
      def execute
        perform
      end

      def perform
        raise StandardError.new("Not Implemented")
      end

      protected

      def framework
        unless Compass::Frameworks[options[:framework]]
          raise Compass::Error.new("No such framework: #{options[:framework].inspect}")
        end
        Compass::Frameworks[options[:framework]]
      end

    end
  end
end
