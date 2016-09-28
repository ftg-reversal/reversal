require 'rails_helper'

describe EventParameter do
  let(:attributes) do
    {
      'title' => 'event title',
      'description' => 'event description',
      'datetime' => '2015-01-02 00:00:00',
      'entry_deadline' => entry_deadline,
      'number' => 3
    }
  end

  let(:reversal_user) { build :reversal_user }

  shared_examples 'イベントの共通部分テスト' do
    it 'タイトルが正しい' do
      expect(event.title).to eq attributes['title']
    end
    it '概要が正しい' do
      expect(event.description).to eq attributes['description']
    end
    it '日時が正しい' do
      expect(event.datetime).to eq Time.zone.parse(attributes['datetime'])
    end
    it 'チーム人数が正しい' do
      expect(event.number).to eq attributes['number']
    end
    it 'イベント管理者が正しい' do
      expect(event.reversal_user).to eq reversal_user
    end
  end

  context 'エントリー締め切りが設定されていないとき' do
    let(:entry_deadline) { '' }
    context '生成されたイベントの' do
      let(:parameter) { EventParameter.new(attributes, reversal_user) }
      let(:event) { Event.new(parameter.to_h) }

      it_behaves_like 'イベントの共通部分テスト'

      it 'エントリー締め切りが存在しない' do
        expect(event.entry_deadline).to eq nil
      end
    end
  end

  context 'エントリー締め切りが設定されていないとき' do
    let(:entry_deadline) { '2015-01-01 00:00:00' }
    context '生成されたイベントの' do
      let(:parameter) { EventParameter.new(attributes, reversal_user) }
      let(:event) { Event.new(parameter.to_h) }

      it_behaves_like 'イベントの共通部分テスト'

      it 'エントリー締め切りが正しい' do
        expect(event.entry_deadline).to eq Time.zone.parse(entry_deadline)
      end
    end
  end
end
