# frozen_string_literal: true

RSpec.describe Wishlists::DestroyOperation do
  subject(:operation) { described_class.new }

  let(:user) { create(:user) }
  let(:guest) { create(:user) }

  let!(:wishlist) { create(:wishlist, user:) }

  describe 'success' do
    context 'when params are correct' do
      let!(:result) { operation.call({ id: wishlist.id }, user) }

      it 'returns destroyed wishlist' do
        expect(result.success?).to be_truthy
        expect(result.value!.title).to eq(wishlist.title)
        expect(result.value!.publicity).to eq(wishlist.publicity)
      end

      it 'destroys the wishlist' do
        expect(Wishlist.find_by(id: wishlist.id)).to be_nil
      end
    end
  end

  describe 'failure' do
    context 'when param values are empty' do
      let!(:result) { operation.call({ id: '' }, user) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:id])
        expect(result.failure[1].errors.messages[0].text).to eq('must be filled')
      end

      it 'does not destroy the wishlist' do
        expect(Wishlist.find_by(id: wishlist.id)).to eq(wishlist)
      end
    end

    context 'when param values are invalid' do
      let!(:result) { operation.call({ id: 'fake-id' }, user) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:id])
        expect(result.failure[1].errors.messages[0].text).to eq('not found')
      end

      it 'does not destroy the wishlist' do
        expect(Wishlist.find_by(id: wishlist.id)).to eq(wishlist)
      end
    end

    context 'when guest destroys users wishlist' do
      let!(:result) { operation.call({ id: wishlist.id }, guest) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:id])
        expect(result.failure[1].errors.messages[0].text).to eq('not found')
      end

      it 'does not destroy the wishlist' do
        expect(Wishlist.find_by(id: wishlist.id)).to eq(wishlist)
      end
    end
  end
end
