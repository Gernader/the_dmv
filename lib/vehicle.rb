require 'date'


class Vehicle
  attr_reader :vin,
              :year,
              :make,
              :model,
              :engine,
              :registration_date

  def initialize(vehicle_details)
    @vin = vehicle_details[:vin]
    @year = vehicle_details[:year]
    @make = vehicle_details[:make]
    @model = vehicle_details[:model]
    @engine = vehicle_details[:engine]
    @registration_date = vehicle_details[:registration_date] || nil
  end

  def antique?
    Date.today.year - @year > 25
  end

  def electric_vehicle?
    @engine == :ev
  end

  def registration_date!
    @registration_date = Date.new
  end

  def plate_type
    if @engine == :ev
      :ev
    elsif Date.today.year - @year > 25
      :antique
    else
      :regular
    end
  end

  
end
