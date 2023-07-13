# frozen_string_literal: true

RSpec.describe Wishlists::UpdateOperation do
  subject(:operation) { described_class.new }

  let(:user) { create(:user) }
  let(:guest) { create(:user) }

  let!(:wishlist) { create(:wishlist, user:) }
  let(:wishlist_params) { attributes_for(:wishlist) }

  describe 'success' do
    context 'when params are correct' do
      let!(:result) { operation.call(wishlist_params.merge(id: wishlist.id), user) }

      it 'returns updated wishlist' do
        expect(result.success?).to be_truthy
        expect(result.value!.title).to eq(wishlist_params[:title])
        expect(result.value!.publicity).to eq(wishlist_params[:publicity])
      end

      it 'updates the wishlist' do
        wishlist_updated = Wishlist.find(wishlist.id)
        expect(wishlist_updated.title).to eq(wishlist_params[:title])
        expect(wishlist_updated.publicity).to eq(wishlist_params[:publicity])
      end
    end
  end

  describe 'failure' do
    context 'when param values are empty' do
      let!(:result) { operation.call({ id: '', title: '', publicity: '' }, user) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:id])
        expect(result.failure[1].errors.messages[0].text).to eq('must be filled')

        expect(result.failure[1].errors.messages[1].path).to eq([:title])
        expect(result.failure[1].errors.messages[1].text).to eq('must be filled')

        expect(result.failure[1].errors.messages[2].path).to eq([:publicity])
        expect(result.failure[1].errors.messages[2].text).to eq('must be filled')
      end

      it 'does not update the wishlist' do
        wishlist_updated = Wishlist.find(wishlist.id)
        expect(wishlist_updated.title).to eq(wishlist.title)
        expect(wishlist_updated.publicity).to eq(wishlist.publicity)
      end
    end

    context 'when param values are invalid' do
      let!(:result) { operation.call({ id: 'fake-id', title: Faker::Lorem.paragraph_by_chars, publicity: Faker::Lorem.paragraph_by_chars }, user) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:title])
        expect(result.failure[1].errors.messages[0].text).to eq('size cannot be greater than 255')

        expect(result.failure[1].errors.messages[1].path).to eq([:publicity])
        expect(result.failure[1].errors.messages[1].text).to eq('must be one of: hidden, by_link, listed')

        expect(result.failure[1].errors.messages[2].path).to eq([:id])
        expect(result.failure[1].errors.messages[2].text).to eq('not found')
      end

      it 'does not update the wishlist' do
        wishlist_updated = Wishlist.find(wishlist.id)
        expect(wishlist_updated.title).to eq(wishlist.title)
        expect(wishlist_updated.publicity).to eq(wishlist.publicity)
      end
    end

    context 'when guest updates users wishlist' do
      let!(:result) { operation.call(wishlist_params.merge(id: wishlist.id), guest) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:id])
        expect(result.failure[1].errors.messages[0].text).to eq('not found')
      end

      it 'does not update the wishlist' do
        wishlist_updated = Wishlist.find(wishlist.id)
        expect(wishlist_updated.title).to eq(wishlist.title)
        expect(wishlist_updated.publicity).to eq(wishlist.publicity)
      end
    end
  end
end
