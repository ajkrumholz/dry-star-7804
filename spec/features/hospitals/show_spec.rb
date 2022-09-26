require 'rails_helper'

RSpec.describe 'hospital show page' do
  let!(:hospital_1) { Hospital.create!(name: "#{Faker::Name.unique.name} Hospital")}
  let!(:hospital_2) { Hospital.create!(name: "#{Faker::Name.unique.name} Hospital")}

  let!(:doctor_1) { hospital_1.doctors.create!(name: "Dr. #{Faker::Name.unique.name}", specialty: Faker::Science.science, university: Faker::University.name )}
  let!(:doctor_2) { hospital_1.doctors.create!(name: "Dr. #{Faker::Name.unique.name}", specialty: Faker::Science.science, university: Faker::University.name )}
  let!(:doctor_3) { hospital_1.doctors.create!(name: "Dr. #{Faker::Name.unique.name}", specialty: Faker::Science.science, university: Faker::University.name )}
  let!(:doctor_4) { hospital_2.doctors.create!(name: "Dr. #{Faker::Name.unique.name}", specialty: Faker::Science.science, university: Faker::University.name )}

  let!(:patient_1) { Patient.create!(name: Faker::Name.unique.name, age: Faker::Number.between(from: 5, to: 95))}
  let!(:patient_2) { Patient.create!(name: Faker::Name.unique.name, age: Faker::Number.between(from: 5, to: 95))}
  let!(:patient_3) { Patient.create!(name: Faker::Name.unique.name, age: Faker::Number.between(from: 5, to: 95))}

  describe 'when I visit a hospital show page' do
    before :each do
      doctor_1.patients << patient_1
      doctor_1.patients << patient_2

      doctor_2.patients << patient_1

      doctor_3.patients << patient_1
      doctor_3.patients << patient_2
      doctor_3.patients << patient_3

      visit hospital_path(hospital_1)
    end

    it 'shows the hospital name' do
      expect(page).to have_content(hospital_1.name)
      expect(page).to_not have_content(hospital_2.name)
    end

    it 'shows the names of all doctors working at the hospital' do
      expect(page).to have_content(doctor_1.name)
      expect(page).to have_content(doctor_2.name)
      expect(page).to have_content(doctor_3.name)
      expect(page).to_not have_content(doctor_4.name)
    end

    it 'for each doctor displays their number of patients' do
      within("#doctor_#{doctor_1.id}") do
        expect(page).to have_content("Patients: #{doctor_1.patients.count}")
      end

      within("#doctor_#{doctor_2.id}") do
        expect(page).to have_content("Patients: #{doctor_2.patients.count}")
      end

      within("#doctor_#{doctor_3.id}") do
        expect(page).to have_content("Patients: #{doctor_3.patients.count}")
      end
    end

    it 'lists doctors in order of number of patients descending' do
      expect(doctor_3.name).to appear_before(doctor_1.name)
      expect(doctor_1.name).to appear_before(doctor_2.name)
    end
  end
end