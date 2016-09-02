require 'rails_helper'

describe VideoFeedRepository do
  let(:condition) { double('VideoSearchConditrion', word: 'hoge', video_site: 'hoge') }

  describe '.find_all_by_condition' do
    let(:list) do
      [
        {
          id:        '1',
          url:       'url1',
          title:     'title1',
          posted_at: Time.zone.now
        },
        {
          id:        '2',
          url:       'url2',
          title:     'title2',
          posted_at: Time.zone.now
        }
      ]
    end

    let(:infrastructure) { double('VideoInfrastructure', exec: list) }

    before do
      allow(VideoFeedRepository).to receive(:condition_to_infrastructure).and_return(infrastructure)
    end

    it 'infrastructure.execの結果のリストに対してそれぞれupdate_or_initialize_videoが呼ばれること' do
      list.map do |hash|
        expect(VideoFeedRepository).to receive(:update_or_initialize_video).with(hash, condition)
      end
      VideoFeedRepository.find_all_by_condition(condition)
    end
  end

  describe '.update_or_initialize_video' do
    let(:date) { Time.zone.now }
    let(:hash) do
      {
        id:        '1',
        url:       'url1',
        title:     'title1',
        posted_at: date
      }
    end

    context '返ってくるVideoの' do
      let(:video) { VideoFeedRepository.update_or_initialize_video(hash, condition) }

      it 'urlが正しい' do
        expect(video.url).to eq hash[:url]
      end
      it 'video_idが正しい' do
        expect(video.video_id).to eq hash[:id]
      end
      it 'video_siteが正しい' do
        expect(video.video_site).to eq condition.video_site
      end
      it 'titleが正しい' do
        expect(video.title).to eq hash[:title]
      end
      it 'posted_atが正しい' do
        expect(video.posted_at).to be_within(1.second).of hash[:posted_at]
      end
    end
  end
end
