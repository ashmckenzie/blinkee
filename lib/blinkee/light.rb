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
          device.open.tap do |h|
            h.set_configuration(device.configurations.first)
            h.claim_interface(0)
          end
        end
      end

      def change_color color
        handle.usb_control_msg(0x21, 0x09, 0x0635, 0x000, "\x65\x0C#{color}\xFF\x00\x00\x00\x00", 0)
      end
  end
end
