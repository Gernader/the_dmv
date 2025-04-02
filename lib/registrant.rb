class Registrant
    attr_reader :name, :age, :licence_data, :permit

    def initialize(name, age, permit = false)
        @name = name
        @age = age
        @permit = permit
        @licence_data = { 
         written: false, 
         liscense: false, 
         renewed: false }

    end
end