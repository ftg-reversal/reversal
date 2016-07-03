module Batch
  class TwitterAds
    class << self
      def exec
        tweet_data.each do |tweet|
          TwitterInfrastructure::Tweet.exec(client, tweet)
        end
      end

      def client
        TwitterInfrastructure::Client.ads_client
      end

      def tweet_data
        [
          '【宣伝】Reversalの目玉機能として「動画検索」があります。 キャラを指定して動画を検索し、自キャラの攻略に役立つ動画をすぐに見つけられます。 対戦組み合わせも表示され、対戦開始時間から動画を再生することができます。 http://twitter.com/ftg_reversal/status/747416383869247488/photo/1',
          '【宣伝】Reversalでは「#○○攻略」のハッシュタグがついたツイートをサイト内に収集します。 集めたツイートはサイト内で閲覧でき、また、ツイート・発言をまとめてページにすることができます。攻略記事や個人用等自由にお使い下さい。 http://twitter.com/ftg_reversal/status/747416420149977090/photo/1',
          '【宣伝】Reversalでは、キャラクターの攻略記事やちょっとしたメモ、簡易ブログなど、自分の好きなページを作成することが出来ます。テキストの色や大きさの設定はもちろん、画像や動画・ツイートの埋込も可能です。 http://twitter.com/ftg_reversal/status/747416438923661312/photo/1',
          '【宣伝】大会イベント告知ページも作成出来ます。エントリー締切機能やシングルから5onまで大会形式が設定でき、格ゲーの大会に特化したページを作成できます。また作成したページでは、事前エントリーが行えスムーズなイベント進行に役立ちます。 http://twitter.com/ftg_reversal/status/747416465037361152/photo/1',
          '【宣伝】Reversalにはプロフィールページ機能があります。自己紹介文や、使用キャラ・段位・ホームグランドの設定・公開が行えます。また作成したページやまとめも表示されます。登録中のプレイヤーは一覧ページで確認できます。 http://twitter.com/ftg_reversal/status/749600890386952192/photo/1'
        ]
      end
    end
  end
end
