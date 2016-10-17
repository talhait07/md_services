class Api::ApplicationController < ApplicationController
  doorkeeper_for :all
end
