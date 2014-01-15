require 'blinkee/devices/delcom_904008'

module Blinkee
  module Devices
    class Factory

      def self.for model
        unless model
          raise 'Not implemented yet'
        end

        model_klass_for(model).new
      end

      def self.model_klass_for model
        Devices.const_get(model.split('_').map { |x| x.capitalize }.join(''))
      end
    end
  end
end
