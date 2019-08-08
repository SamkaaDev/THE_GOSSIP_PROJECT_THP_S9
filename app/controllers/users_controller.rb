class UsersController < ApplicationController
  def show
  	@id = params[:id]
    @first_name = User.all.find(@id).first_name
  	@users = User.all.find(@id)
  end

  def new
    @user = User.new
  end

  def create
    puts "£" * 60
    puts @user
    puts "£" * 60
    city = City.find_or_create_by(name: params[:name])
    zip_code = City.find_or_create_by(zip_code: params[:zip_code])
    @user = User.create(first_name: post_params[:first_name], last_name: post_params[:last_name], email: post_params[:email], city: city, zip_code: zip_code, age: post_params[:age], description: post_params[:description], password: post_params[:password], password_confirmation: post_params[:password_confirmation])
      if @user.save 
          flash[:success] = "Vous êtes inscrits !"
          session[:user_id] = @user.id
          redirect_to index_path
      else
          render :new
      end
  end

  def edit
  end

  def update
  end

  def destroy
  end




  private 

  def post_params
    params.require(:user).permit(:first_name, :last_name, :email, :age, :city, :zip_code, :description, :password, :password_confirmation)
  end

end
