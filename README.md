# The DMV

This is the starter repo for the BE Mod1 DMV project.

# Iteration 1 

- All tests passing.
- Branched and merged.
    - registrant class 
    - name, age, permit-default false

# Iteration 2

## register a vehicle
## rules
- The DMV allows facilities to perform the following services:
    - Register a vehicle
        - Vehicles have the following rules:
            - Vehicles 25 years old or older are considered antique and cost $25 to register
            - Electric Vehicles (EV) cost $200 to register
            - All other vehicles cost $100 to register
            - A vehicle’s plate_type should be set to :regular, :antique, or :ev upon successful registration.
    - Administer a written test
        - A written test can only be administered to registrants with a permit and who are at least 16 years of age
    - Administer a road test
        - A road test can only be administered to registrants who have passed the written test
        - For simplicity’s sake, Registrants who qualify for the road test automatically earn a license
    - Renew a driver’s license
        - A license can only be renewed if the registrant has already passed the road test and earned a license

- facility.registered_vehicles  X
- facility.collected_fees       X
- facility.register_vehicle     X
- vehicle.registraation_date    X
- vehicle.plate_type            X

## getting a license

- facility.administer_written_test(arg)
    - check for service/age/permit
- facility.administer_road_test(arg)
    - check for written test/service
- facility.renew_drivers_license(arg)
    - renew if licence is true

