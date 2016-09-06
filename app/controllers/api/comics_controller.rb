class Api::ComicsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :json

  def index
    comics = FetchComics.perform(comic_params[:title], comic_params[:page])
    if comics.success?
      respond_with comics.result, :represent_items_with => ComicRepresenter
    end
  end

  def upvotes
    up_votes = FetchUpVotes.perform
    respond_with up_votes.result, :represent_items_with => UpVotesRepresenter
  end

  def upvote
    up_vote = UpVote.perform(up_vote_params[:comic_id])

    if up_vote.success?
      render json: { success: true, error: nil }
    else
      render json: { success: false, error: 'Vote failed to save' }
    end
  end

  private

  def comic_params
    params.permit(:page, :title, :format)
  end

  def up_vote_params
    params.permit(:comic_id)
  end
end
