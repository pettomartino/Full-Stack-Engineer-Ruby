class UpVote
  include ::UseCase

  def initialize(comic_id)
    @comic_id = comic_id
  end

  def perform
    create_or_increase
  end

  private

  attr_reader :comic_id

  def create_or_increase
    comic = ComicVote.find_or_initialize_by(comic_id: comic_id)
    comic.votes += 1
    comic.save.tap do |success|
      errors.add(:base, 'Vote failed to save') unless success
    end
  end
end