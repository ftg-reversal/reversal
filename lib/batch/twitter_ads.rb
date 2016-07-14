module Batch
  class TwitterAds
    class << self
      def exec
        TwitterInfrastructure::Tweet.exec(client, tweet_data.sample)
      end

      def client
        TwitterInfrastructure::Client.ads_client
      end

      # rubocop:disable Metrics/LineLength
      def tweet_data
        [
          '【宣伝1】Reversalの目玉機能として「動画検索」があります。 キャラを指定して動画を検索し、自キャラの攻略に役立つ動画をすぐに見つけられます。 対戦組み合わせも表示され、対戦開始時間から動画を再生することができます。 http://twitter.com/ftg_reversal/status/747416383869247488/photo/1',
          '【宣伝2】Reversalでは「#○○攻略」のハッシュタグがついたツイートをサイト内に収集します。 集めたツイートはサイト内で閲覧でき、また、ツイート・発言をまとめてページにすることができます。攻略記事や個人用等自由にお使い下さい。 http://twitter.com/ftg_reversal/status/747416420149977090/photo/1',
          '【宣伝3】Reversalでは、キャラクターの攻略記事やちょっとしたメモ、簡易ブログなど、自分の好きなページを作成することが出来ます。テキストの色や大きさの設定はもちろん、画像や動画・ツイートの埋込も可能です。 http://twitter.com/ftg_reversal/status/747416438923661312/photo/1',
          '【宣伝4】大会イベント告知ページも作成できます。エントリー締切機能やシングルから5onまで大会形式が設定でき、格ゲーの大会に特化したページを作成できます。また作成したページでは事前エントリーが行えスムーズなイベント進行に役立ちます。 http://twitter.com/ftg_reversal/status/747416465037361152/photo/1',
          '【宣伝5】Reversalにはプロフィールページ機能があります。自己紹介文や、使用キャラ・段位・ホームグランドの設定・公開が行えます。また作成したページやまとめも表示されます。登録中のプレイヤーは一覧ページで確認できます。 http://twitter.com/ftg_reversal/status/749600890386952192/photo/1',
          '【宣伝6】動画・ページ・イベント・エントリーなどの新着情報をTOPページでアクティビティという形で確認出来ます。いち早く最新の情報を確認するのに便利です。個人のアクティビティについてもプロフィールページから見ることができます。 http://twitter.com/ftg_reversal/status/749851041160540160/photo/1',
          '【宣伝7】Reversalでは動画・ページ・まとめ・イベントで良いと思ったものにGoodと送ることができます。Goodされたユーザは自分のコンテンツの評価が分かり、またコンテンツ毎にGood数とGoodしたユーザが表示されます。 http://twitter.com/ftg_reversal/status/752125742310318090/photo/1',
          '【宣伝8】Reversalに収集された動画に対して、対戦の組み合わせと対戦開始時間を編集する機能を追加しました。ユーザーの皆様に編集していただくことで、これまで以上に、より正確な対戦組み合わせを表示することが出来ます。 http://twitter.com/ftg_reversal/status/752695160375422976/photo/1'
        ]
      end
      # rubocop:enable Metrics/LineLength
    end
  end
end
