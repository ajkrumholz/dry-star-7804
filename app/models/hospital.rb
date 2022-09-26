class Hospital < ApplicationRecord
  has_many :doctors

  def ordered_doctors
    doctors.joins(:patients)
      .select('count(patient_id) as patient_count, doctors.*')
      .group('doctors.id')
      .order(patient_count: :desc)
  end
end
