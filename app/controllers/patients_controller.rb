class PatientsController < ApplicationController
  def index
    @adult_patients = Patient.adult_patients
  end
end