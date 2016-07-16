require 'rails_helper'
require 'webmock/rspec'

module NicovideoInfrastructure
  describe TagSearch do
    describe '.exec' do
      # RSSへのアクセスをWebMockに差し替え
      before do
        WebMock.stub_request(:any, 'http://www.nicovideo.jp/tag/hoge?sort=f&rss=2.0')
          .to_return(status: 200, body: fixture('infrastructures/nicovideo_infrastructure/tag_search.xml'))
      end

      it 'XMLに含まれている数の動画情報が取得できること' do
        expect(TagSearch.exec('hoge').length).to eq 2
      end

      context '取得された1件目の動画について' do
        let(:video) { TagSearch.exec('hoge').first }

        it 'URLが正しいこと' do
          expect(video[:url]).to eq 'http://www.nicovideo.jp/watch/video1'
        end

        it 'タイトルが正しいこと' do
          expect(video[:title]).to eq 'Video1'
        end

        it '投稿日時が正しいこと' do
          expect(video[:posted_at]).to eq Time.parse('2015-01-01 00:00:00 +0900')
        end
      end
    end

    describe 'private' do
      it 'tagに応じたRSSのURLが取得できること' do
        expect(TagSearch.send(:rss_url, 'hoge')).to(
          eq 'http://www.nicovideo.jp/tag/hoge?sort=f&rss=2.0')
      end
    end
  end
end
