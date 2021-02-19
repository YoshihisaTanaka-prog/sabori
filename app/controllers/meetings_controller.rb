class MeetingsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_meeting, only: %i[ show edit update destroy ]

  # GET /meetings or /meetings.json
  def index

    respond_to do |format|
      format.html {
        min = current_user.start_number
        max = current_user.start_number + 98
        @meetings = Meeting.where(eventId: min - 1..max)
        @num1 = Meeting.where(eventId: 100..199).length
        @num2 = Meeting.where(eventId: 200..299).length
        @num3 = Meeting.where(eventId: 300..399).length
        @num4 = Meeting.where(eventId: 400..499).length
      }
      format.xlsx {
        # ファイル名をここで指定する（動的にファイル名を変更できる）
        min = current_user.start_number - 1
        max = current_user.start_number + 98
        @meetings = Meeting.where(eventId: min..max)
        @programs = Program.where(event_id: min..max)
        @performers = Performer.where(event_id: min..max)
        response.headers['Content-Disposition'] = "attachment; filename=(新フォーマット)講演リスト.xlsx"
      }
    end

  end

  # GET /meetings/1 or /meetings/1.json
  def show
    @programs = Program.where(event_id: @meeting.eventId)
  end

  # GET /meetings/new
  def new
    min = current_user.start_number
    max = current_user.start_number + 98
    @num = current_user.start_number + Meeting.where(eventId: min..max).length
    @meeting = Meeting.new
  end

  # GET /meetings/1/edit
  def edit
  end

  # POST /meetings or /meetings.json
  def create
    @meeting = Meeting.new(meeting_params)

    respond_to do |format|
      if @meeting.save
        format.html { redirect_to @meeting, notice: "Meeting was successfully created." }
        format.json { render :show, status: :created, location: @meeting }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meetings/1 or /meetings/1.json
  def update
    respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to @meeting, notice: "Meeting was successfully updated." }
        format.json { render :show, status: :ok, location: @meeting }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @meeting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meetings/1 or /meetings/1.json
  def destroy
    max = current_user.start_number + 98
    programs = Program.where(event_id: @meeting.eventId..max)
    programs.each do |p|
      if p.event_id == @meeting.eventId
        p.destroy
      elsif p.event_id > @meeting.eventId
        p.event_id -= 1
        p.save
      end
    end

    performers = Performer.where(event_id: @meeting.eventId..max)
    performers.each do |p|
      if p.event_id == @meeting.eventId
        p.destroy
      elsif p.event_id > @meeting.eventId
        p.event_id -= 1
        p.save
      end
    end

    meetings = Meeting.where(eventId: @meeting.eventId..max)
    meetings.each do |m|
      if m.eventId > @meeting.eventId
        m.eventId -= 1
        m.save
      end
    end

    @meeting.destroy
    respond_to do |format|
      format.html { redirect_to meetings_url, notice: "Meeting was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meeting
      @meeting = Meeting.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def meeting_params
      params.require(:meeting).permit(:eventId, :fiscalYear, :eventNumber, :field, :title, :keyword, :organization, :start, :end, :place, :url)
    end
end
