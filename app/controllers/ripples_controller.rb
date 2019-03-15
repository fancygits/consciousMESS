class RipplesController < ApplicationController
  before_action :set_ripple, only: [:show]
  before_action :redirect_user, only: [:edit, :update, :destroy]
  before_action :set_page, only: [:index]
  before_action :get_total_pages

  # GET /ripples
  # GET /ripples.json
  def index
    @page = session[:page].to_i
    @total_pages = session[:total_pages].to_i
    @ripples = Ripple.order(created_at: :desc).limit(10).offset((@page - 1) * 10)
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
        session[:page] = 1
        format.html { redirect_to root_path, notice: 'Ripple was successfully created.' }
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
   session.delete(:total_pages)
   respond_to do |format|
     format.html { redirect_to root_path, notice: 'Ripple was successfully destroyed.' }
     format.json { head :no_content }
   end
  end

  # Sets the page number and redirects to root to display that page's records
  def page
    page = params[:page].to_i.clamp(1, session[:total_pages].to_i)
    session[:page] = page
    redirect_to root_path
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

    def redirect_user
      redirect_to root_path, notice: "Once something is said, it cannot be unsaid."
    end

    def set_page
      session[:page] ||= 1
    end

    def get_total_pages
      session[:total_pages] = (Ripple.all.count / 10.0).ceil
    end
end
