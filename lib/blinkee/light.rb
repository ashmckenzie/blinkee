require './colors'

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
      change_color(0xFF)
    end

    private

      attr_reader :device

      def change_color color
        device.handle.usb_control_msg(0xc8, 0x12, 0x020a, colour, "", 0)
      end
  end
end
