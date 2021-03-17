class PerformersController < ApplicationController

  before_action :authenticate_user!
  before_action :set_performer, only: %i[ show edit update destroy ]

  # GET /performers or /performers.json
  def index
    @performers = Performer.all
  end

  # GET /performers/1 or /performers/1.json
  def show
    @program = Program.where(event_id: @performer.event_id.to_i, event_program_id: @performer.event_program_id.to_i).first
  end

  # GET /performers/new
  def new
    @performer = Performer.new
    @program = Program.where(event_id: params["eventId"],event_program_id: params["event_program_id"]).first
  end

  # GET /performers/1/edit
  def edit
    @program = Program.where(event_id: @performer.event_id, event_program_id: @performer.event_program_id).first
  end

  # POST /performers or /performers.json
  def create
    @performer = Performer.new(performer_params)
    @program = Program.where(event_id: @performer.event_id.to_i, event_program_id: @performer.event_program_id.to_i).first
    # render plain: @performer.id
    respond_to do |format|
      if @performer.save
        format.html { redirect_to "/programs/" + @program.id.to_s + "/edit", notice: "Performer was successfully created." }
        format.json { render :show, status: :created, location: @performer }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @performer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /performers/1 or /performers/1.json
  def update
    @program = Program.where(event_id: @performer.event_id, event_program_id: @performer.event_program_id).first
    respond_to do |format|
      if @performer.update(performer_params)
        format.html { redirect_to "/programs/" + @program.id.to_s, notice: "Performer was successfully updated." }
        format.json { render :show, status: :ok, location: @performer }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @performer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /performers/1 or /performers/1.json
  def destroy
    @program = Program.where(event_id: @performer.event_id, event_program_id: @performer.event_program_id).first
    @performer.destroy
    respond_to do |format|
      format.html { redirect_to "/programs/" + @program.id.to_s, notice: "Performer was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_performer
      @performer = Performer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def performer_params
      params.require(:performer).permit(:event_id, :event_program_id, :organization, :role, :lastname, :firstname)
    end
end
