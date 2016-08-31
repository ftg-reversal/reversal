require 'rails_helper'

describe ImperialRepository do
  describe '.find_all_by_video' do
    fixtures :chara

    before do
      allow(ImperialInfrastructure::MatchupDetector).to receive(:exec).and_return(hash)
    end

    let(:hash) do
      ActiveSupport::JSON.decode(fixture('infrastructures/imperial_infrastructure/matchup_detector.json').read)
    end

    let(:video) do
      build(:video)
    end

    context '返ってくるVideoMatchupの配列の' do
      let(:matchups) do
        ImperialRepository.find_all_by_video(video)
      end
      it '個数が正しい' do
        expect(matchups.size).to eq hash.size
      end

      context '1個目について' do
        let(:matchup) do
          matchups.first
        end

        it '1pのキャラが正しい' do
          expect(matchup.chara1.name).to eq 'ソル'
        end
        it '2pのキャラが正しい' do
          expect(matchup.chara2.name).to eq 'カイ'
        end

        it 'secが正しい' do
          expect(matchup.sec).to eq 10
        end
      end
    end
  end
end
