require './spec/spec_helper'
require 'pry'

class Dmv
  attr_reader :facilities

  def initialize
    @facilities = []
  end

  def add_facility(facility)
    @facilities.push(facility)
  end

  def facilities_offering_service(service)
    @facilities.find_all do |facility|
      facility.services.include?(service)
    end
  end

  def co_facilities(details)
    details.map do |detail|
      Facility.new(
        name: detail[:dmv_office],
        address: detail[:address_li],
        address1: detail[:address__1],
        phone: detail[:phone],
        services: detail[:services_p] || [],
        registered_vehicles: detail[:registered_vehicles] || [],
        collected_fees: 0
  

      )
    end
  end

end
