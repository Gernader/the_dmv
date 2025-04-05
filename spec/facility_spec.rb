require 'spec_helper'

RSpec.describe Facility do
  before(:each) do
    @facility = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
  end
  describe '#initialize' do
    it 'can initialize' do
      expect(@facility).to be_an_instance_of(Facility)
      expect(@facility.name).to eq('DMV Tremont Branch')
      expect(@facility.address).to eq('2855 Tremont Place Suite 118 Denver CO 80205')
      expect(@facility.phone).to eq('(720) 865-4600')
      expect(@facility.services).to eq([])
    end
  end

  describe '#add service' do
    it 'can add available services' do
      expect(@facility.services).to eq([])
      @facility.add_service('New Drivers License')
      @facility.add_service('Renew Drivers License')
      @facility.add_service('Vehicle Registration')
      expect(@facility.services).to eq(['New Drivers License', 'Renew Drivers License', 'Vehicle Registration'])
    end
  end

  describe '#register vehicle' do
    it 'can register a vehicle' do
      @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
      @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
      @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
      @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
      @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )

      @facility_1.register_vehicle(@cruz)

      expect(@facility_1.registered_vehicles).to include(@cruz)
    end

    it 'can calculate fees' do
      @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
      @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
      @cruz = Vehicle.new({vin: '123456789abcdefgh', year: 2012, make: 'Chevrolet', model: 'Cruz', engine: :ice} )
      @bolt = Vehicle.new({vin: '987654321abcdefgh', year: 2019, make: 'Chevrolet', model: 'Bolt', engine: :ev} )
      @camaro = Vehicle.new({vin: '1a2b3c4d5e6f', year: 1969, make: 'Chevrolet', model: 'Camaro', engine: :ice} )

      expect(@facility_1.collected_fees).to eq(0)

      @facility_1.register_vehicle(@cruz)

      expect(@facility_1.collected_fees).to eq(100)

      @facility_2.register_vehicle(@bolt)
      @facility_2.register_vehicle(@camaro)
      
      expect(@facility_2.collected_fees).to eq(225)
    end
  end

  describe '#liscence testing' do
    it 'can administer a written test' do
      @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
      @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
      @registrant_1 = Registrant.new('Bruce', 18, true )
      @registrant_2 = Registrant.new('Penny', 16 )
      @registrant_3 = Registrant.new('Tucker', 15 )

      # binding.pry
      @facility_1.administer_written_test(@registrant_1)

      expect(@registrant_1.license_data[:written]).to eq(false)

      @facility_1.add_service('Written Test')

      @facility_1.administer_written_test(@registrant_1)

      expect(@registrant_1.license_data[:written]).to eq(true)

      @facility_1.administer_written_test(@registrant_2)

      expect(@registrant_2.license_data[:written]).to eq(false)
    end

    it 'can administer a road test' do
      @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
      @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
      @registrant_1 = Registrant.new('Bruce', 18, true )
      @registrant_2 = Registrant.new('Penny', 16 )
      @registrant_3 = Registrant.new('Tucker', 15 )
      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(@registrant_1)

      @facility_1.administer_road_test(@registrant_1)

      expect(@registrant_1.license_data[:license]).to eq(false)

      @facility_1.add_service('Road Test')
      @facility_1.administer_road_test(@registrant_1)

      expect(@registrant_1.license_data[:license]).to eq(true)
      @facility_1.administer_road_test(@registrant_2)

      expect(@registrant_2.license_data[:license]).to eq(false)
    end

    it 'can renew licenses' do
      @facility_1 = Facility.new({name: 'DMV Tremont Branch', address: '2855 Tremont Place Suite 118 Denver CO 80205', phone: '(720) 865-4600'})
      @facility_2 = Facility.new({name: 'DMV Northeast Branch', address: '4685 Peoria Street Suite 101 Denver CO 80239', phone: '(720) 865-4600'})
      @registrant_1 = Registrant.new('Bruce', 18, true )
      @registrant_2 = Registrant.new('Penny', 16 )
      @registrant_3 = Registrant.new('Tucker', 15 )
      @facility_1.add_service('Written Test')
      @facility_1.administer_written_test(@registrant_1)
      @facility_1.add_service('Road Test')
      @facility_1.administer_road_test(@registrant_1)

      @facility_1.renew_drivers_license(@registrant_1)
      expect(@registrant_1.license_data[:renewed]).to eq(false)

      @facility_1.add_service('Renew License')
      @facility_1.renew_drivers_license(@registrant_1)
      expect(@registrant_1.license_data[:renewed]).to eq(true)

      @facility_1.renew_drivers_license(@registrant_3)
      expect(@registrant_3.license_data[:renewed]).to eq(false)

      @facility_2.add_service('Renew License')
      @facility_2.renew_drivers_license(@registrant_2)
      expect(@registrant_2.license_data[:renewed]).to eq(false)

    end
  end
end
