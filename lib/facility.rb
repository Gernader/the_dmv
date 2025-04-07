require 'date'
require './lib/dmv_data_service'
require 'pry'


class Facility
  attr_reader :name, 
              :address,
              :address_1,
              :phone, 
              :services, 
              :registered_vehicles,
              :collected_fees
  
  def initialize(attributes)
    @name = attributes[:name]
    @address = attributes[:address]
    @address_1 = attributes[:address_1] || []
    @phone = attributes[:phone]
    @services = attributes[:services] || []
    @registered_vehicles = attributes[:registered_vehicles] || [nil]
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

  def administer_written_test(registrant)
    
    if registrant.permit == true && (registrant.age >= 16 && @services.include?("Written Test")) 
      registrant.license_data[:written] = true
    end
  end

  def administer_road_test(registrant)
    if registrant.license_data[:written] == true && @services.include?("Road Test")
      registrant.license_data[:license] = true
    end
  end

  def renew_drivers_license(registrant)
    if registrant.license_data[:license] == true && @services.include?("Renew License")
       registrant.license_data[:renewed] = true
    end   
  end

  # def co_facilities(details)
    
  #   details.map do |detail|
  #     Facility.new(
  #       name: detail[:dmv_office],
  #       address: detail[:address_li],
  #       address_1: detail[:adress__1],
  #       phone: detail[:phone],
  #       services: detail[:services_p] || [],
  #       registered_vehicles: detail[:registered_vehicles] || [],
  #       collected_fees: 0
  #     )
  #   end
  # end

  # def ny_facilities(details)
  #   details.map do |detail|
  #     Facility.new(
  #       name: detail[:office_name],
  #       address: detail[:street_addess_line_1],
  #       address1: detail[:city],
  #       phone: detail[:phone],
  #       services: [],
  #       registered_vehicles: [],
  #       collected_fees: 0
  #     )
  #   end
  # end

end
