class ResumesController < ApplicationController
  def new
  end

  def create
    Worker.resume_upload(params[:file])

    redirect_to new_resumes_path, notice: "Resume was successfully uploaded."
  end
end
