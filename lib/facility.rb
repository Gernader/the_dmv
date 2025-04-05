require 'date'
class Facility
  attr_reader :name, 
              :address, 
              :phone, 
              :services, 
              :registered_vehicles,
              :collected_fees
  
  def initialize(attributes)
    @name = attributes[:name]
    @address = attributes[:address]
    @phone = attributes[:phone]
    @services = attributes[:services] || []
    @registered_vehicles = attributes[:registered_vehicles] || []
    @collected_fees = attributes[:collected_fees] || 0
  end

  def add_service(service)
    @services.append(service)
  end

  def register_vehicle(car)
    car.registration_date!
    @registered_vehicles.push(car)
    
    case car.plate_type
    when :ev
      @collected_fees += 200
    when :regular
      @collected_fees += 100
    when :antique 
      @collected_fees += 25
    end
  end

  
  

end
