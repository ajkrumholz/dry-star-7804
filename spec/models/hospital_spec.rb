require 'rails_helper'

RSpec.describe Hospital do
  it {should have_many :doctors}

  describe 'instance methods' do

    let!(:hospital) { Hospital.create!(name: "#{Faker::Name.unique.name} Hospital")}

    let!(:doctor_1) { hospital.doctors.create!(name: "Dr. #{Faker::Name.unique.name}", specialty: Faker::Science.science, university: Faker::University.name )}
    let!(:doctor_2) { hospital.doctors.create!(name: "Dr. #{Faker::Name.unique.name}", specialty: Faker::Science.science, university: Faker::University.name )}
    let!(:doctor_3) { hospital.doctors.create!(name: "Dr. #{Faker::Name.unique.name}", specialty: Faker::Science.science, university: Faker::University.name )}

    let!(:patient_1) { Patient.create!(name: Faker::Name.unique.name, age: Faker::Number.between(from: 5, to: 95))}
    let!(:patient_2) { Patient.create!(name: Faker::Name.unique.name, age: Faker::Number.between(from: 5, to: 95))}
    let!(:patient_3) { Patient.create!(name: Faker::Name.unique.name, age: Faker::Number.between(from: 5, to: 95))}

    before :each do
      doctor_1.patients << patient_1
      doctor_1.patients << patient_2
      doctor_2.patients << patient_1
      doctor_3.patients << patient_1
      doctor_3.patients << patient_2
      doctor_3.patients << patient_3
    end
    describe 'ordered_doctors' do
      it 'returns an array of doctor objects ordered by their number of patients' do
        expect(hospital.ordered_doctors).to eq([doctor_3, doctor_1, doctor_2])
      end
    end
  end
end
