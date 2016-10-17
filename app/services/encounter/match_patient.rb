class Encounter::MatchPatient

  #MATCH_MINIMUM = 3
  #MATCHABLE_DEMOGRAPHICS = [:first_name, :last_name, :birth_date, :phone_number, :email]

  COMBINATIONS = [
    [:first_name, :last_name, :birth_date],
    [:first_name, :last_name, :phone_number],
    [:first_name, :last_name, :email],
    [:first_name, :birth_date, :phone_number],
    [:first_name, :birth_date, :email],
    [:first_name, :phone_number, :email],
    [:last_name, :birth_date, :phone_number],
    [:last_name, :birth_date, :email],
    [:last_name, :phone_number, :email],
    [:birth_date, :phone_number, :email]
  ]

  def self.call(row)
    patient = nil
    #COMBINATIONS.each do |combo|
    #  patient = Patient.where(combo[0] => row[combo[0]] & combo[1] => row[combo[1]] & combo[2] => row[combo[2]])
    #
    #  break unless patient.nil?
    #end

    patient
  end
end
