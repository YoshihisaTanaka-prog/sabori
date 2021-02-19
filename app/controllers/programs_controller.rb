class ProgramsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_program, only: %i[ show edit update destroy ]

  # GET /programs or /programs.json
  def index
    @programs = Program.all
  end

  # GET /programs/1 or /programs/1.json
  def show
    @meeting = Meeting.where(eventId: @program.event_id).first
    @performers = Performer.where(event_id: @program.event_id, event_program_id: @program.event_program_id)
  end

  # GET /programs/new
  def new
    @program = Program.new
    @meeting = Meeting.where(eventId: params["event_id"]).first
    @num = Program.where(event_id: params["event_id"]).length + 1
  end

  # GET /programs/1/edit
  def edit
    @meeting = Meeting.where(eventId: @program.event_id).first
  end

  # POST /programs or /programs.json
  def create
    @program = Program.new(program_params)
    @meeting = Meeting.where(eventId: @program.event_id).first
    respond_to do |format|
      if @program.save
        format.html { redirect_to "/meetings/" + @meeting.id.to_s, notice: "Program was successfully created." }
        format.json { render :show, status: :created, location: @program }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /programs/1 or /programs/1.json
  def update
    @meeting = Meeting.where(eventId: @program.event_id).first
    respond_to do |format|
      if @program.update(program_params)
        format.html { redirect_to "/meetings/" + @meeting.id.to_s, notice: "Program was successfully updated." }
        format.json { render :show, status: :ok, location: @program }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @program.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /programs/1 or /programs/1.json
  def destroy
    max = current_user.start_number + 98
    @meeting = Meeting.where(eventId: @program.event_id).first

    performers = Performer.where(event_id: @program.event_id, event_program_id: @program.event_program_id..max)
    performers.each do |p|
      if p.event_program_id == @program.event_program_id
        p.destroy
      elsif p.event_program_id > @program.event_program_id
        p.event_program_id -= 1
        p.save
      end
    end

    programs = Program.where(event_id: @program.event_id, event_program_id: @program.event_program_id..max)
    programs.each do |p|
      if p.event_program_id == @program.event_program_id
        p.destroy
      elsif p.event_program_id > @program.event_program_id
        p.event_program_id -= 1
        p.save
      end
    end

    @program.destroy
    respond_to do |format|
      format.html { redirect_to "/meetings/" + @meeting.id.to_s, notice: "Program was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def program_params
      params.require(:program).permit(:event_program_id, :event_id, :title, :date, :start, :end)
    end
end
