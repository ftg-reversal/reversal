require 'rails_helper'

module NicovideoInfrastructure
  describe VideoThumbnail do
    it 'sm***が渡されたとき正しいサムネイルURLが取得出来ること' do
      expect(VideoThumbnail.exec('http://www.nicovideo.jp/watch/sm12345')).to(eq 'http://tn-skr2.smilevideo.jp/smile?i=12345')
    end

    it 'nm***が渡されたとき正しいサムネイルURLが取得出来ること' do
      expect(VideoThumbnail.exec('http://www.nicovideo.jp/watch/nm12345')).to(eq 'http://tn-skr2.smilevideo.jp/smile?i=12345')
    end

    it 'それ以外のURLが渡されたときnilが返ってくること' do
      expect(VideoThumbnail.exec('http://www.nicovideo.jp/watch/12345')).to be_nil
    end
  end
end
