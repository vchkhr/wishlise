# frozen_string_literal: true

RSpec.describe Wishlists::IndexOperation do
  subject(:operation) { described_class.new }

  let(:user) { create(:user) }
  let(:profile) { create(:profile, user: user) }
  let(:guest) { create(:user) }
  let(:anonymous) { nil }

  let!(:wishlists_listed) { create_list(:wishlist, 3, publicity: 'listed', user: user) }
  let!(:wishlists_by_link) { create_list(:wishlist, 3, publicity: 'by_link', user: user) }
  let!(:wishlists_hidden) { create_list(:wishlist, 3, publicity: 'hidden', user: user) }

  describe 'success' do
    context 'when current guest requests their wishlists' do
      let!(:result) { operation.call({}, user) }

      it 'returns wishlists' do
        expect(result.success?).to be_truthy
        expect(result.value!).to eq((wishlists_listed + wishlists_by_link + wishlists_hidden).sort_by(&:updated_at).reverse)
      end
    end

    context 'when guest requests their wishlists' do
      let!(:result) { operation.call({}, guest) }

      it 'returns listed wishlists' do
        expect(result.success?).to be_truthy
        expect(result.value!).to be_empty
      end
    end

    context 'when user requests users wishlists' do
      let!(:result) { operation.call({ username: profile.username }, user) }

      it 'returns listed wishlists' do
        expect(result.success?).to be_truthy
        expect(result.value!).to eq(wishlists_listed.sort_by(&:updated_at).reverse)
      end
    end

    context 'when guest requests users wishlists' do
      let!(:result) { operation.call({ username: profile.username }, guest) }

      it 'returns listed wishlists' do
        expect(result.success?).to be_truthy
        expect(result.value!).to eq(wishlists_listed.sort_by(&:updated_at).reverse)
      end
    end

    context 'when anonymous requests users wishlists' do
      let!(:result) { operation.call({ username: profile.username }, anonymous) }

      it 'returns listed wishlists' do
        expect(result.success?).to be_truthy
        expect(result.value!).to eq(wishlists_listed.sort_by(&:updated_at).reverse)
      end
    end
  end

  describe 'failure' do
    context 'when param values are invalid' do
      let!(:result) { operation.call({ username: 'fake-username' }, user) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:username])
        expect(result.failure[1].errors.messages[0].text).to eq('not found')
      end
    end
  end
end
