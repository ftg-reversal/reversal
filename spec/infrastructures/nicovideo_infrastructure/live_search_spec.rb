require 'rails_helper'
require 'webmock/rspec'

module NicovideoInfrastructure
  describe LiveSearch do
    context '正常系' do
      before do
        WebMock.stub_request(:any, 'http://api.search.nicovideo.jp/api/v2/live/contents/search?q=ggxrd&targets=tags&fields=contentId,title,startTime,communityIcon&_sort=-startTime&filters[liveStatus][0]=onair&_offset=0&_limit=100&_context=reversal')
          .to_return(status: 200, body: fixture('infrastructures/nicovideo_infrastructure/live_search.json'))
      end

      let(:lives) { LiveSearch.exec('ggxrd') }

      it 'JSONに含まれている配信情報数が正しいこと' do
        expect(lives.size).to eq 3
      end

      context '取得された1件目の配信について' do
        let(:live) { lives.first }

        it 'IDが正しいこと' do
          expect(live[:id]).to eq 'lv1'
        end

        it 'URLが正しいこと' do
          expect(live[:url]).to eq 'http://live.nicovideo.jp/watch/lv1'
        end

        it 'タイトルが正しいこと' do
          expect(live[:title]).to eq 'LIVE_TITLE1'
        end

        it '開始時間が正しいこと' do
          expect(live[:start_time]).to eq Time.zone.parse('2015-01-01 00:00:00 +0900')
        end

        it 'アイコンURLが正しいこと' do
          expect(live[:icon_url]).to eq 'http://icon.nimg.jp/community/1/co1.jpg'
        end
      end
    end

    context '異常系' do
      before do
        WebMock.stub_request(:any, 'http://api.search.nicovideo.jp/api/v2/live/contents/search?q=ggxrd&targets=tags&fields=contentId,title,startTime,communityIcon&_sort=-startTime&filters[liveStatus][0]=onair&_offset=0&_limit=100&_context=reversal')
          .to_return(status: 503)
      end

      let(:lives) { LiveSearch.exec('ggxrd') }

      it '空配列が返ってくること' do
        expect(lives).to eq []
      end
    end
  end
end
