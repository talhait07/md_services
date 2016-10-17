class Encounter::ConvertRowArrayToHash

  FIELDS = {
    reference: 0,
    first_name: 1,
    last_name: 2,
    birth_date: 3,
    phone_number: 4,
    email: 5,
    balance: 6
  }

  def self.call(csv_row)
    row = {}

    FIELDS.keys.each do |key|
      row[key] = csv_row[FIELDS[key]]
    end

    row
  end
end
