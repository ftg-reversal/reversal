require 'rails_helper'
require 'webmock/rspec'

module NicovideoInfrastructure
  describe GetThumbInfo do
    before do
      WebMock.stub_request(:any, 'http://ext.nicovideo.jp/api/getthumbinfo/sm1')
        .to_return(status: 200, body: fixture('infrastructures/nicovideo_infrastructure/get_thumb_info.xml'))
    end

    context '取得された動画の情報について' do
      let(:video) { GetThumbInfo.exec('sm1') }

      it 'IDが正しいこと' do
        expect(video[:id]).to eq 'sm1'
      end

      it 'URLが正しいこと' do
        expect(video[:url]).to eq 'http://www.nicovideo.jp/watch/sm1'
      end

      it 'タイトルが正しいこと' do
        expect(video[:title]).to eq 'VIDEO_TITLE'
      end

      it '投稿日時が正しいこと' do
        expect(video[:posted_at]).to eq Time.zone.parse('2015-01-01 00:00:00 +0900')
      end
    end
  end
end
