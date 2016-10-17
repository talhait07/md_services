require('csv')

class Encounter::ProcessCsv

  def self.call(csv)
    encounters = []

    CSV.foreach(csv.path) do |row|
      # Converts the csv row array to a mapped hash :reference, :first_name, :last_name, :birth_date, etc.
      row = Encounter::ConvertRowArrayToHash.call(row)

      encounter = Encounter.find_by_reference(row[:reference])

      if encounter
        Encounter::Reconcile.call(encounter, row)
      else
        encounter = site.encounters.new(row)
        # patient presence is required, so if it does not match we will get an error.
        encounter.patient = Encounter::MatchPatient.call(site, row)
        encounter.save
      end

      encounter.push(encounter)
    end

    encounters
  end
end
