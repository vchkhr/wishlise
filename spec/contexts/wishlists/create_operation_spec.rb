# frozen_string_literal: true

RSpec.describe Wishlists::CreateOperation do
  subject(:operation) { described_class.new }

  let(:user) { create(:user) }
  let(:wishlist_params) { attributes_for(:wishlist) }

  describe 'success' do
    context 'when params are correct' do
      let!(:result) { operation.call(wishlist_params, user) }

      it 'returns created wishlist' do
        expect(result.success?).to be_truthy
        expect(result.value!.title).to eq(wishlist_params[:title])
        expect(result.value!.publicity).to eq(wishlist_params[:publicity])
      end

      it 'creates the wishlist' do
        new_wishlist = Wishlist.last
        expect(new_wishlist.title).to eq(wishlist_params[:title])
        expect(new_wishlist.publicity).to eq(wishlist_params[:publicity])
      end
    end
  end

  describe 'failure' do
    context 'when param values are empty' do
      let!(:result) { operation.call({ title: '', publicity: '' }, user) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:title])
        expect(result.failure[1].errors.messages[0].text).to eq('must be filled')

        expect(result.failure[1].errors.messages[1].path).to eq([:publicity])
        expect(result.failure[1].errors.messages[1].text).to eq('must be filled')
      end

      it 'does not create the wishlist' do
        expect(Wishlist.count).to eq(0)
      end
    end

    context 'when param values are invalid' do
      let!(:result) { operation.call({ title: Faker::Lorem.paragraph_by_chars, publicity: Faker::Lorem.paragraph_by_chars }, user) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:title])
        expect(result.failure[1].errors.messages[0].text).to eq('size cannot be greater than 255')

        expect(result.failure[1].errors.messages[1].path).to eq([:publicity])
        expect(result.failure[1].errors.messages[1].text).to eq('must be one of: hidden, by_link, listed')
      end

      it 'does not create the wishlist' do
        expect(Wishlist.count).to eq(0)
      end
    end
  end
end
