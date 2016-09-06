class FetchComics
  include ::UseCase

  attr_reader :result

  def initialize(title, page, api_client = Marvel::Client.new)
    @title = title
    @page = page
    @api_client = api_client
  end

  def perform
    @result = fetch_comics
  end

  private

  attr_reader :api_client, :title, :page

  def fetch_comics
    api_client.comics(search_params)
  end

  def search_params
    search = { orderBy: '-onsaleDate', format: 'comic', offset: offset }
    search[:title] = title if title
    search
  end

  def offset
    20 * page.to_i
  end
end
