require 'rails_helper'

module RedisInfrastructure
  describe RedisSet do
    context '正常系' do
      before do
        RedisSet.client = double('client', set: nil)
      end

      it 'RedisInfrastructure::Keyを渡したとき期待した値がセットされること' do
        expect(RedisSet.client).to receive(:set).with(Key.dummy_key.to_s, 'str')
        RedisSet.exec(Key.dummy_key, 'str')
      end
    end

    context '異常系' do
      it 'RedisInfrastructure::Key以外を渡したとき例外が発生すること' do
        expect { RedisSet.exec(nil, 'str') }.to raise_error(TypeError)
      end
    end
  end
end
