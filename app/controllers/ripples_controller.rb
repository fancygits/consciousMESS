class RipplesController < ApplicationController
  before_action :set_ripple, only: [:show, :edit, :update, :destroy]
  before_action :set_page, only: [:index]

  # GET /ripples
  # GET /ripples.json
  def index
    @ripples = Ripple.order(:created_at).limit(10).offset(@page_num * 10)
  end

  # GET /ripples/1
  # GET /ripples/1.json
  def show
  end

  # GET /ripples/new
  def new
    @ripple = Ripple.new
  end

  # GET /ripples/1/edit
  def edit
  end

  # POST /ripples
  # POST /ripples.json
  def create
    @ripple = Ripple.new(ripple_params)

    respond_to do |format|
      if @ripple.save
        format.html { redirect_to @ripple, notice: 'Ripple was successfully created.' }
        format.json { render :show, status: :created, location: @ripple }
      else
        puts @ripple.errors.full_messages
        format.html { render :new }
        format.json { render json: @ripple.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ripples/1
  # PATCH/PUT /ripples/1.json
  def update
   respond_to do |format|
     if @ripple.update(ripple_params)
       format.html { redirect_to @ripple, notice: 'Ripple was successfully updated.' }
       format.json { render :show, status: :ok, location: @ripple }
     else
       format.html { render :edit }
       format.json { render json: @ripple.errors, status: :unprocessable_entity }
     end
   end
  end

  # DELETE /ripples/1
  # DELETE /ripples/1.json
  def destroy
   @ripple.destroy
   respond_to do |format|
     format.html { redirect_to ripples_url, notice: 'Ripple was successfully destroyed.' }
     format.json { head :no_content }
   end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ripple
      @ripple = Ripple.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ripple_params
      params.require(:ripple).permit(:name, :url, :message)
    end

    def set_page
      if params[:page].present?
        @page_num = params[:page].to_i
      else
        @page_num = 0
      end
    end
end

