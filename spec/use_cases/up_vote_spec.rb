require 'rails_helper'

RSpec.describe FetchComics do

  context 'when a vote is given' do
    it 'create a ComicVote if no exists' do
      expect { UpVote.perform(123) }.to change { ComicVote.count }.by 1
    end

    it 'increases votes amount if ComicVote exists for the comic_id' do
      UpVote.perform(123)
      UpVote.perform(123)

      comic_votes = ComicVote.find_by(comic_id: 123)

      expect(comic_votes.votes).to eql 2
    end
  end
end
