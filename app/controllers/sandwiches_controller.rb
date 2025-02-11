class SandwichesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @sandwiches = Sandwich.all
  end

end
