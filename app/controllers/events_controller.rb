class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @future = Event.future
    @past = Event.past
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @invites = Invite.all
  end

  # GET /events/new
  def new
    if current_user
      @event = Event.new
      @users = User.all
      @invite = Invite.new
    else
      redirect_to new_user_path
    end
  end

  # GET /events/1/edit
  def edit
    @users = User.all
  end

  # POST /events
  # POST /events.json
  def create
    @users = User.all

    @event = current_user.events.build(event_params.except(:invites))

    respond_to do |format|
      if @event.save

        event_params.slice(:invites).values.each do |x|
          x.each do |y|
            if y.empty?
            else
              user = @users.find(y.to_i)
              @event.attendees << user
            end
          end
        end
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
    @users = User.all
    respond_to do |format|
      if @event.update(event_params.except(:invites))

        event_params.slice(:invites).values.each do |x|
          x.each do |y|
            if y.empty?
            else
              user = @users.find(y.to_i)
              @event.attendees << user
            end
          end
        end
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:time, :location, :title, :description, :creator_id, invites: [])
  end
end
