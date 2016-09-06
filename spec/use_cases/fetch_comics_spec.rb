require 'rails_helper'

RSpec.describe FetchComics do

  describe "#perform" do

    let(:api_result) { [{ title: 'x-man'}, {title: 'deadpool'}] }
    let(:api_client) { double('api_client') }

    context 'when requests comics on page 0' do
      it 'returns comics from api with offset equals 0' do
        allow(api_client).to receive(:comics).with(
          orderBy: '-onsaleDate',
          format: 'comic',
          title: 'x-men',
          offset: 0).and_return(api_result)

        subject = described_class.perform('x-men', 0, api_client)

        expect(subject.result).to eq api_result
      end
    end

    context 'when requests comics on page 1' do
      it 'returns comics from api with offset equals 20' do
        allow(api_client).to receive(:comics).with(
          orderBy: '-onsaleDate',
          format: 'comic',
          title: 'x-men',
          offset: 20).and_return(api_result)

        subject = described_class.perform('x-men', 1, api_client)

        expect(subject.result).to eq api_result
      end
    end

    context 'when no title was given' do
      it 'returns comics from api without title' do
        allow(api_client).to receive(:comics).with(
          orderBy: '-onsaleDate',
          format: 'comic',
          offset: 0).and_return(api_result)

        subject = described_class.perform(nil, 0, api_client)

        expect(subject.result).to eq api_result
      end
    end
  end
end