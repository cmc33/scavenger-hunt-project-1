class CluesController < ApplicationController
  respond_to :js

  def index
  end

  def new
    @list = List.find(params[:list_id])
    @clue = Clue.new
  end

  def create
    @clue = Clue.create({
      latitude: params["latitude"],
      longitude: params["longitude"],
      text: params["text"],
      answer: params["answer"],
      list_id: params["list_id"]
      })
    @list = List.find(params[:list_id])
    respond_to do |format|
      format.js { }
      format.html {render partial: "new", layout: false}
    end
  end

  def show
    @clue = Clue.find(params[:id])
  end

  def validate
    @clue = Clue.find(params[:clue_id])
    user_answer = params[:answer]
    user_location = [params[:latitude], params[:longitude]]
    if @clue.submission_valid?(user_answer, user_location)

      @clue = Clue.find(params[:clue_id].to_i + 1)
      respond_to do |format|
        format.html {render layout: false}
      end
    end
    # render @clue
    # "/lists/#{params[:current_list_id].to_i}/clues/#{params[:clue_id].to_i + 1}"
    # redirect_to root_path
  end
  # def answer
  #   # binding.pry
  # end

  private



end
