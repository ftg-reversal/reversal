require 'rails_helper'

module RedisInfrastructure
  describe RedisGet do
    context '正常系' do
      before do
        RedisGet.client = double('Redis Client', get: 1)
      end

      it 'RedisInfrastructure::RedisKeyを渡したとき期待した値が返ってくること' do
        expect(RedisGet.exec(RedisKey.dummy_key)).to eq 1
      end
    end

    context '異常系' do
      it 'RedisInfrastructure::RedisKey以外を渡したとき例外が発生すること' do
        expect { RedisGet.exec(nil) }.to raise_error(TypeError)
      end
    end
  end
end
