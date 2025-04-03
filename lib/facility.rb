require 'date'
class Facility
  attr_reader :name, :address, :phone, :services, :registered_vehicles
  
  def initialize(attributes)
    @name = attributes[:name]
    @address = attributes[:address]
    @phone = attributes[:phone]
    @services = attributes[:services] || []
    @registered_vehicles = attributes[:registered_vehicles] || []
    
  end

  def add_service(service)
    @services.append(service)
  end

  def register_vehicle(car)
    car.registration_date!
    @registered_vehicles.push(car)
    binding.pry
  end

  

end
