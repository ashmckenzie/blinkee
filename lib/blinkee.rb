require 'blinkee/version'
require 'blinkee/discover'
require 'blinkee/light'

module Blinkee

  def self.new device_type=nil
    Blinkee.new(device_type)
  end

  class Blinkee

    def initialize device_type=nil
      @device_type = device_type
    end

    def light
      @light ||= begin
        Light.new(device)
      end
    end

    def device
      @device ||= begin
        Discover.new(device_type).find
      end
    end

    private

      attr_reader :device_type
  end

end
