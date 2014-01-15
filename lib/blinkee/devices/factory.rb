require './delcom_904008'
require './light'

module Blinkee
  module Devices
    class Factory

      def self.for light_model
        unless light_model
          raise 'Not implemented yet'
        end

        Light.new(model_klass_for(model).new)
      end

      def self.model_klass_for model
        model.split('_').map { |x| x.capitalize }.join('')
      end
    end
  end
end
