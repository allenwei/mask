module Mask
  class Property
    attr_reader :name
    attr_reader :options

    def initialize(name, options={})
      @name = name
      @options = options
    end

    def presenter
      self.options[:presenter]
    end

    def klass
      self.options[:klass]
    end
  end
end
