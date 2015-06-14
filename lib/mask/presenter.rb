module Mask
  module Presenter

    def self.included(base)
      base.extend PresenterClassMethods
      base.instance_eval do 
        def extended(object)
          object.extend ObjectExtention
          object.mask_properties = self.mask_properties
        end
      end
    end

    module PresenterClassMethods
      def property(name, options={})
        @mask_properties ||= []
        @mask_properties << Property.new(name, options)
        @mask_properties
      end
      
      def mask_properties
        @mask_properties ||= []
      end
    end

    module ObjectExtention
      def mask_properties
        @mask_properties
      end

      def mask_properties=(mask_properties)
        @mask_properties = mask_properties
      end

      def to_hash
        self.mask_properties.inject({}) do |result, property|
          value = self.send(property.name)
          if value && property.presenter
            value.extend property.presenter
            result[property.name] = value.to_hash
          else
            result[property.name] = value
          end
          result
        end
      end

      def from_hash(hash)
        self.mask_properties.each do |property|
          value = hash[property.name.to_sym] || hash[property.name.to_s]
          if value && property.klass
            object = property.klass.new
            object.extend property.presenter
            object.from_hash(value)
            self.send("#{property.name.to_sym}=", object)
          else
            self.send("#{property.name.to_sym}=", value) if value
          end
        end
      end
    end
  end
end
