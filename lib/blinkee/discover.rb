require 'usb'

Dir[File.join('./lib', 'blinkee', 'device_types', '*')].each { |f| require(f) }

module Blinkee
  class Discover

    def initialize device_type_name=nil
      @device_type_name = device_type_name
    end

    def find
      device = usb_devices.detect do |d|
        device_types_to_search.detect do |dt|
          match?(d, dt)
        end
      end

      unless device
        message = if device_type
          "Could not discover a '#{device_type}'"
        else
          'Could not discover any known devices connected :('
        end

        raise message
      end

      device
    end

    private

      attr_reader :device_type_name

      def device_types_to_search
        @device_types_to_search ||= begin
          if device_type
            [ device_type ]
          else
            DeviceTypes.constants.map { |x| DeviceTypes.const_get(x) }
          end
        end
      end

      def device_type
        @device_type ||= begin
          if device_type_name
            DeviceTypes.const_get(device_type_name.split('_').map { |x| x.capitalize }.join(''))
          else
            nil
          end
        end
      end

      def usb_devices
        USB.devices
      end

      def match? device, device_type
        device.idVendor == device_type::VENDOR_ID && device.idProduct == device_type::PRODUCT_ID
      end
  end
end
