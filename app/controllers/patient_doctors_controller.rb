class PatientDoctorsController < ApplicationController
  def destroy
    @patient_doctor = PatientDoctor.find(params[:id])
    @doctor = @patient_doctor.doctor
    @patient_doctor.destroy
    redirect_to doctor_path(@doctor)
  end
end