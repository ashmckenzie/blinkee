require 'blinkee/version'
require 'blinkee/devices/factory'
require 'blinkee/light'

module Blinkee

  def self.new model=nil
    Blinkee.new(model)
  end

  class Blinkee

    def initialize model=nil
      @model = model
    end

    def light
      @light ||= begin
        Light.new(device)
      end
    end

    def device
      @device ||= begin
        Devices::Factory.for(model)
      end
    end

    private

      attr_reader :model
  end

end
