require 'rails_helper'

describe EntryParameter do
  let(:attributes) do
    {
      entry: {
        comment: 'entry comment'
      }
    }
  end

  let(:event) { build :event }
  let(:reversal_user) { build :reversal_user }

  context '生成されたパラメータの' do
    let(:parameter) { EntryParameter.new(attributes, event, reversal_user) }
    let(:param) { parameter.to_h }

    it 'コメントが正しい' do
      expect(param[:comment]).to eq attributes[:entry][:comment]
    end

    it 'イベントが正しい' do
      expect(param[:event]).to eq event
    end

    it 'エントリーユーザーが正しい' do
      expect(param[:reversal_user]).to eq reversal_user
    end
  end
end
