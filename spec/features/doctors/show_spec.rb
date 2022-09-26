require 'rails_helper'

RSpec.describe 'doctor show page' do
  describe 'a show page for an individual doctor' do
    let!(:hospital) { Hospital.create!(name: "#{Faker::Name.unique.name} Hospital")}
    let!(:doctor_1) { hospital.doctors.create!(name: "Dr. #{Faker::Name.unique.name}", specialty: Faker::Science.science, university: Faker::University.name )}
    let!(:doctor_2) { hospital.doctors.create!(name: "Dr. #{Faker::Name.unique.name}", specialty: Faker::Science.science, university: Faker::University.name )}

    let!(:patient_1) { Patient.create!(name: Faker::Name.unique.name, age: Faker::Number.between(from: 5, to: 95))}
    let!(:patient_2) { Patient.create!(name: Faker::Name.unique.name, age: Faker::Number.between(from: 5, to: 95))}
    let!(:patient_3) { Patient.create!(name: Faker::Name.unique.name, age: Faker::Number.between(from: 5, to: 95))}
    let!(:patient_4) { Patient.create!(name: Faker::Name.unique.name, age: Faker::Number.between(from: 5, to: 95))}
    let!(:patient_5) { Patient.create!(name: Faker::Name.unique.name, age: Faker::Number.between(from: 5, to: 95))}

    it 'shows the doctors information' do
      visit doctor_path(doctor_1)

      expect(page).to have_content(doctor_1.name)
      expect(page).to have_content(doctor_1.specialty)
      expect(page).to have_content(doctor_1.university)
      expect(page).to_not have_content(doctor_2.name)
    end

    it 'shows the name of the hospital where the doctor works' do
      visit doctor_path(doctor_1)

      expect(page).to have_content(doctor_1.hospital.name)
    end

    describe 'patient list' do
      it 'lists the names of all patients the doctor sees' do
        doctor_1.patients << patient_1
        doctor_1.patients << patient_2
        doctor_1.patients << patient_3

        visit doctor_path(doctor_1)

        within("#patient_list") do
          expect(page).to have_content(patient_1.name)
          expect(page).to have_content(patient_2.name)
          expect(page).to have_content(patient_3.name)
          expect(page).to_not have_content(patient_4.name)
          expect(page).to_not have_content(patient_5.name)
        end
      end

      it 'displays a link to remove the patient from the doctor' do
        doctor_1.patients << patient_1
        doctor_1.patients << patient_2

        visit doctor_path(doctor_1)

        expect(page).to have_link("Unassign #{patient_1.name}")
        expect(page).to have_link("Unassign #{patient_2.name}")
      end

      describe 'when I click the link' do
        before :each do
          doctor_1.patients << patient_1
          doctor_1.patients << patient_2
          doctor_2.patients << patient_1
        end
        it 'removes that patient from the drs care' do
          visit doctor_path(doctor_1)

          expect(page).to have_content(patient_1.name)
          expect(page).to have_content(patient_2.name)
          click_link "Unassign #{patient_1.name}"

          expect(current_path).to eq(doctor_path(doctor_1))
          expect(page).to have_content(patient_2.name)
          expect(page).to_not have_content(patient_1.name)
        end

        it 'does not delete the patient entirely' do
          visit doctor_path(doctor_1)

          click_link "Unassign #{patient_1.name}"
          expect(page).to_not have_content(patient_1.name)

          visit doctor_path(doctor_2)
          expect(page).to have_content(patient_1.name)
        end
      end
    end
  end
end