require 'usb'

module Blinkee
  module Devices
    class Base

      attr_reader :device

      def initialize
        @device = find_device!
      end

      def handle
        @handle ||= begin
         handle = device.open

         begin
           # ruby-usb bug: the arity of rusb_detach_kernel_driver_np isn't defined correctly, it should only accept a single argument.
           if USB::DevHandle.instance_method(:usb_detach_kernel_driver_np).arity == 2
             handle.usb_detach_kernel_driver_np(0, 0)
           else
             handle.usb_detach_kernel_driver_np(0)
           end
         rescue Errno::ENODATA => e
           # Already detached
         end

         handle.set_configuration(device.configurations.first)
         handle.claim_interface(0)
         handle
        end
      end

      private

        def find_device!
          device = USB.devices.find do |device|
            device.idVendor == self.class::VENDOR_ID && device.idProduct == self.class::PRODUCT_ID
          end

          raise "Cannot find a #{self.class}" unless device

          device
        end
    end
  end
end
