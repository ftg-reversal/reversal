require 'rails_helper'

module TwitterInfrastructure
  describe Search do
    context '正常系' do
      let(:number) { 5 }
      let(:tweets) do
        tweet_struct = Struct.new(:id, :user, :text, :created_at)
        user_struct = Struct.new(:screen_name)

        tweets = []
        number.times do |i|
          tweets.push(tweet_struct.new(i, user_struct.new("user#{i}"), "text#{i}", Time.zone.now))
        end
        tweets
      end

      before do
        allow(Search).to receive(:search_tweets).with(Client.dummy_client, 'text').and_return(tweets)
      end

      it '返ってきたツイートの件数のハッシュが取得出来る' do
        expect(Search.exec(Client.dummy_client, 'text').size).to eq number
      end

      context '返ってきたツイートの1件目について' do
        let(:tweet) { Search.exec(Client.dummy_client, 'text').first }

        it 'idが正しいこと' do
          expect(tweet[:id]).to eq 0
        end

        it 'screen_nameが正しいこと' do
          expect(tweet[:screen_name]).to eq 'user0'
        end

        it 'textが正しいこと' do
          expect(tweet[:text]).to eq 'text0'
        end
      end
    end

    context '異常系' do
      let(:client) do
        client = double('Twitter Client')
        allow(client).to receive(:search).and_raise
      end

      it '例外が発生したとき空配列が返ること' do
        expect(Search.exec(client, 'text')).to eq []
      end
    end
  end
end
