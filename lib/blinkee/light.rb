require 'blinkee/colors'

module Blinkee
  class Light

    def initialize device
      @device = device
    end

    def success!
      change_color(Colors::GREEN)
    end

    def failure!
      change_color(Colors::RED)
    end

    def building!
      change_color(Colors::YELLOW)
    end

    def warning!
      change_color(Colors::ORANGE)
    end

    def off!
      change_color(Colors::OFF)
    end

    private

      attr_reader :device

      def handle
        @handle ||= begin
         handle = device.open

         # begin
         #   # ruby-usb bug: the arity of rusb_detach_kernel_driver_np isn't defined correctly, it should only accept a single argument.
         #   if USB::DevHandle.instance_method(:usb_detach_kernel_driver_np).arity == 2
         #     handle.usb_detach_kernel_driver_np(0, 0)
         #   else
         #     handle.usb_detach_kernel_driver_np(0)
         #   end
         # rescue Errno::ENODATA => e
         #   # Already detached
         # end

         handle.set_configuration(device.configurations.first)
         handle.claim_interface(0)
         handle
        end
      end

      def change_color color
        handle.usb_control_msg(0x21, 0x09, 0x0635, 0x000, "\x65\x0C#{color}\xFF\x00\x00\x00\x00", 0)
      end
  end
end
