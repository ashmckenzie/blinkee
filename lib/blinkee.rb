require 'blinkee/version'
require 'blinkee/devices/factory'

class Blinkee

  extend self

  def initialize light_model=nil
    @light_model = light_model
  end

  def light
    @light ||= begin
      Factory.for(light_model)
    end
  end

  private

    attr_reader :light_model

end
