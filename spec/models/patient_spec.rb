require 'rails_helper'

RSpec.describe Patient do
  describe 'relationships' do
    it { should have_many :patient_doctors}
    it { should have_many(:doctors).through(:patient_doctors)}
  end

  describe 'class methods' do
    describe '#adult_patients' do
      let!(:patient_1) { Patient.create!(name: "Cranky Cocoon", age: Faker::Number.between(from: 19, to: 95))}
      let!(:patient_2) { Patient.create!(name: "Angie Armadillo", age: Faker::Number.between(from: 19, to: 95))}
      let!(:patient_3) { Patient.create!(name: "Butters Bonaventure", age: Faker::Number.between(from: 19, to: 95))}
      let!(:patient_4) { Patient.create!(name: "Flam Florgen", age: Faker::Number.between(from: 5, to: 18))}
      let!(:patient_5) { Patient.create!(name: "Zardoz the Magnificent", age: Faker::Number.between(from: 5, to: 18))}
    
      it 'returns an array of patient objects with age greater than 18, sorted alpha ascending' do
        expect(Patient.adult_patients).to eq([patient_2, patient_3, patient_1])
      end
    end

  
  end
end