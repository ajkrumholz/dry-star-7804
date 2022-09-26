require 'rails_helper'

RSpec.describe 'patient index' do
  describe 'when I visit the patient index' do
    let!(:patient_1) { Patient.create!(name: "Cranky Cocoon", age: Faker::Number.between(from: 19, to: 95))}
    let!(:patient_2) { Patient.create!(name: "Angie Armadillo", age: Faker::Number.between(from: 19, to: 95))}
    let!(:patient_3) { Patient.create!(name: "Butters Bonaventure", age: Faker::Number.between(from: 19, to: 95))}
    let!(:patient_4) { Patient.create!(name: "Flam Florgen", age: Faker::Number.between(from: 5, to: 18))}
    let!(:patient_5) { Patient.create!(name: "Zardoz the Magnificent", age: Faker::Number.between(from: 5, to: 18))}

    before :each do
      visit patients_path
    end

    it 'lists the names of all adult patients' do
      expect(page).to have_content(patient_1.name)
      expect(page).to have_content(patient_2.name)  
      expect(page).to have_content(patient_3.name)  
      expect(page).to_not have_content(patient_4.name)  
      expect(page).to_not have_content(patient_5.name)  
    end

    it 'lists names alphabetically ascending' do
      expect(patient_2.name).to appear_before(patient_3.name)
      expect(patient_3.name).to appear_before(patient_1.name)
    end
  end
end