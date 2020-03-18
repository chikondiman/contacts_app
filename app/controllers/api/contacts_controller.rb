class Api::ContactsController < ApplicationController
  def index
    @contacts = Contact.all
    # render "index.json.jb"

    p "THIS IS RIGHT BEFORE CURRENT USER"
    p current_user
    p "THIS IS RIGHT AFTER CURRENT USER"

    if params[:search]
      @contacts = Contact.where("name LIKE ?", "%#{params[:search]}%")
    else
      @contacts = Contact.all
    end

    if current_user
      @contacts = Contact.all
    else
      @contacts = Contact.all
    end
    render "index.json.jb"
  end

  def show
    the_id = params[:id]
    @contact = Contact.find_by(id: the_id)
    render "show.json.jb"
  end

  def create
    results = Geocoder.search(params[:address])
    latitude = results.first.coordinates[0]
    longitude = results.first.coordinates[1]

    @contact = Contact.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      address: params[:address],
    )

    if @contact.save
      render "show.json.jb"
    else
      render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    the_id = params[:id]
    @contact = Contact.find_by(id: the_id)
    @contact.first_name = params[:first_name] || @contact.first_name
    @contact.last_name = params[:last_name] || @contact.last_name
    @contact.middle_name = params[:middle_name] || @contact.middle_name
    @contact.email = params[:email] || @contact.email
    @contact.phone_number = params[:phone_number] || @contact.phone_number
    @contact.address = Geocoder.coordinates(params[:address]) || @contact.address

    if @contact.save
      render "show.json.jb"
    else
      render json: { errors: @contact.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    render "destroy.json.jb"
  end
end
