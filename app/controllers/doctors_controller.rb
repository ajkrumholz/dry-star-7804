class DoctorsController < ApplicationController
  def show
    @doctor = Doctor.find(params[:id])
    @hospital = @doctor.hospital
  end
end