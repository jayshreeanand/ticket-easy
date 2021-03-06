class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy, :attend, :unattend]
  before_action :authenticate_user!, :except => [:show, :index]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    if params[:filter] == "Past"
      @events = @events.where('start_time < ?', DateTime.now)
    elsif params[:filter] =="Future"
      @events = @events.where('start_time > ?', DateTime.now)
    end
    @events = @events.order('created_at ASC').paginate(:page => params[:page], :per_page => 12)
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def attend
    respond_to do |format|
      if @event.register(current_user)
        format.html { redirect_to my_events_path, notice: 'Event booking successfully created.' }
        format.json { render my_events_path, status: :ok }
      else
        format.html { render :show }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def unattend
    respond_to do |format|
      if @event.unregister(current_user)
        format.html { redirect_to my_events_path, notice: 'Event booking successfully cancelled.'}
        format.json { render my_events_path, status: :ok }
      else
        format.html { render :show }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def user_events
    @events = current_user.bookings.includes(:event).where(attending: true).collect{ |b| b.event }
    @events.sort_by!{|e| e[:start_time]} #sorting user's events for display
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :description, :start_time, :duration, :venue)
    end
end
