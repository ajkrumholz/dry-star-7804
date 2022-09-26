class Doctor < ApplicationRecord
  belongs_to :hospital
  has_many :patient_doctors
  has_many :patients, through: :patient_doctors

  def patient_doctor(patient)
    PatientDoctor.where(
      doctor_id: self.id, 
      patient_id: patient.id)
      .first  
  end
end
