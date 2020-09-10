class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy]

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
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
    # @event = Event.new(event_params)
    # @event.user_id = current_user.id
    # @event.invites << @user

    respond_to do |format|
      if @event.save

        event_params.slice(:invites).values.each do |x|
          x.each do |y|
            if y.empty?
            else
              user = @users.find(y.to_i) # unless y.strip.empty?
              @event.attendees << user
            end
          end
        end
        # event_params.slice(:invites).each do |user_id|
        #   p user_id
        #   # p 'CHECK HERE'
        #   # p @users.find(user_id) if user_id.class == Integer
        #   #   @users.each do |user|
        #   # puts user_id
        # end

        # @event.attendees << current_user

        # @invite = Invite.new(event_params)

        # params[:invites].each do |user|
        #   @event.attendees << user
        # end
        # @invite = @event.users.build(invite_params)
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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:time, :location, :title, :description, :creator_id, invites: [])
    # , invites: [:id])
  end
end
