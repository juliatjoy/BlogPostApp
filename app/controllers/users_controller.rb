class UsersController < ApplicationController
  def profile
    binding.pry
    @user = current_user
  end
end
