require 'rails_helper'
require 'webmock/rspec'

module ImperialInfrastructure
  describe MatchupDetector do
    context '正常系' do
      before do
        WebMock.stub_request(:any, 'http://imperial/20/100/sm1')
          .to_return(status: 200, body: fixture('infrastructures/imperial_infrastructure/matchup_detector.json'))
      end

      let(:matchups) { MatchupDetector.exec('sm1') }

      it '返ってくるMatchupの数が正しいこと' do
        expect(matchups.length).to eq 2
      end

      context '取得された1件目のMatchupについて' do
        let(:matchup) { MatchupDetector.exec('sm1').first }

        it '1pが正しいこと' do
          expect(matchup['1p']).to eq 'Sol'
        end

        it '2pが正しいこと' do
          expect(matchup['2p']).to eq 'Ky'
        end

        it '秒数が正しいこと' do
          expect(matchup['sec']).to eq 10
        end
      end
    end

    context '異常系' do
      before do
        WebMock.stub_request(:any, 'http://imperial/20/100/sm1')
          .to_return(status: 503)
      end

      let(:matchups) { MatchupDetector.exec('sm1') }

      it '空配列が返ってくる' do
        expect(matchups).to eq []
      end
    end
  end
end
