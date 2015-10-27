require 'rails_helper'
require 'webmock/rspec'

module NicovideoInfrastructure
  describe VideoThumbnail do
    describe '.exec' do
      context 'sm***が渡されたとき' do
        it '正しいサムネイルURLが取得出来ること' do
          expect(VideoThumbnail.exec('http://www.nicovideo.jp/watch/sm12345')).to(
            eq 'http://tn-skr2.smilevideo.jp/smile?i=12345')
        end
      end

      context 'nm***が渡されたとき' do
        it '正しいサムネイルURLが取得出来ること' do
          expect(VideoThumbnail.exec('http://www.nicovideo.jp/watch/nm12345')).to(
            eq 'http://tn-skr2.smilevideo.jp/smile?i=12345')
        end
      end

      context 'それ以外のURLが渡されたとき' do
        it 'nilが返ってくること' do
          expect(VideoThumbnail.exec('http://www.nicovideo.jp/watch/12345')).to be_nil
        end
      end
    end
  end
end
