require 'rails_helper'

RSpec.describe Doctor do
  it {should belong_to :hospital}
  it {should have_many :patient_doctors}
  it {should have_many(:patients).through(:patient_doctors)}

  describe 'instance methods' do
    let!(:hospital) { Hospital.create!(name: "#{Faker::Name.unique.name} Hospital")}
    let!(:doctor_1) { hospital.doctors.create!(name: "Dr. #{Faker::Name.unique.name}", specialty: Faker::Science.science, university: Faker::University.name )}
    let!(:patient_1) { Patient.create!(name: Faker::Name.unique.name, age: Faker::Number.between(from: 5, to: 95))}
    let!(:patient_2) { Patient.create!(name: Faker::Name.unique.name, age: Faker::Number.between(from: 5, to: 95))}

    before :each do
      doctor_1.patients << patient_1
      doctor_1.patients << patient_2
    end

    describe '#patient_doctor(patient)' do
      it 'given a patient, returns the relevant doctor_patient obj' do
        patient_doctor_1 = PatientDoctor.where(doctor_id: doctor_1.id, patient_id: patient_1.id).first
        patient_doctor_2 = PatientDoctor.where(doctor_id: doctor_1.id, patient_id: patient_2.id).first

        expect(doctor_1.patient_doctor(patient_1)).to eq(patient_doctor_1)
        expect(doctor_1.patient_doctor(patient_2)).to eq(patient_doctor_2)
      end
    end
  end
end
