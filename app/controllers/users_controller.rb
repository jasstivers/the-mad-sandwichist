class UsersController < ApplicationController

  def show
      @user = User.find(params[:id])
      # @unearned_badges = @user.badges.map { |badge|
      #   badge.where(earned: false)
      # }
      @allbadges = Merit::Badge.all
      @userbadges = @user.badges
  end
end
