require 'rails_helper'

describe TwitterApiRepository do
  describe '.find_unsent_tweet' do
    let(:last_tweet_num) { 1 }

    let(:condition) do
      double('Twitter2slackCondition', text: 'hoge', last_tweet: last_tweet_num)
    end

    let(:tweets) do
      [
        { id: 1 },
        { id: 2 },
        { id: 3 }
      ]
    end

    before do
      allow(TwitterApiRepository).to receive(:find_by_text).and_return(tweets)
    end

    context '返ってきたハッシュについて' do
      it '個数が正しい' do
        unsent_tweet = TwitterApiRepository.find_unsent_tweet(condition).size
        expect(unsent_tweet).to eq tweets.select { |tweet| tweet[:id] > last_tweet_num }.size
      end
    end
  end

  describe '.find_by_text' do
    let(:hash) do
      [
        { id: 2 },
        { id: 1 },
        { id: 3 }
      ]
    end

    before do
      allow(TwitterInfrastructure::Search).to receive(:exec).and_return(hash)
    end

    context '返ってきたハッシュの配列が:idでソートされている' do
      let(:tweets) { TwitterApiRepository.find_by_text('hoge') }
      it '1つ目' do
        expect(tweets.first[:id]).to eq 1
      end
      it '2つ目' do
        expect(tweets.second[:id]).to eq 2
      end
      it '3つ目' do
        expect(tweets.third[:id]).to eq 3
      end
    end
  end
end
