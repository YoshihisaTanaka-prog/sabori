class Excel1sController < ApplicationController
  before_action :set_excel1, only: %i[ show edit update destroy ]

  # GET /excel1s or /excel1s.json
  def index
    @excel1s = Excel1.all
  end

  # GET /excel1s/1 or /excel1s/1.json
  def show
  end

  # GET /excel1s/new
  def new
    @excel1 = Excel1.new
  end

  # GET /excel1s/1/edit
  def edit
  end

  # POST /excel1s or /excel1s.json
  def create
    @excel1 = Excel1.new(excel1_params)

    respond_to do |format|
      if @excel1.save
        format.html { redirect_to @excel1, notice: "Excel1 was successfully created." }
        format.json { render :show, status: :created, location: @excel1 }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @excel1.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /excel1s/1 or /excel1s/1.json
  def update
    respond_to do |format|
      if @excel1.update(excel1_params)
        format.html { redirect_to @excel1, notice: "Excel1 was successfully updated." }
        format.json { render :show, status: :ok, location: @excel1 }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @excel1.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /excel1s/1 or /excel1s/1.json
  def destroy
    @excel1.destroy
    respond_to do |format|
      format.html { redirect_to excel1s_url, notice: "Excel1 was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_excel1
      @excel1 = Excel1.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def excel1_params
      params.require(:excel1).permit(:title, :body)
    end
end
