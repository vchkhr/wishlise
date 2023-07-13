# frozen_string_literal: true

RSpec.describe Wishlists::ShowOperation do
  subject(:operation) { described_class.new }

  let(:user) { create(:user) }
  let(:guest) { create(:user) }
  let(:anonymous) { nil }

  let(:wishlist_listed) { create(:wishlist, publicity: 'listed', user:) }
  let(:wishlist_by_link) { create(:wishlist, publicity: 'by_link', user:) }
  let(:wishlist_hidden) { create(:wishlist, publicity: 'hidden', user:) }

  describe 'success' do
    context 'when user requests listed wishlist' do
      let!(:result) { operation.call({ id: wishlist_listed.id }, user) }

      it 'returns wishlist' do
        expect(result.success?).to be_truthy
        expect(result.value!).to eq(wishlist_listed)
      end
    end

    context 'when user requests by_link wishlist' do
      let!(:result) { operation.call({ id: wishlist_by_link.id }, user) }

      it 'returns wishlist' do
        expect(result.success?).to be_truthy
        expect(result.value!).to eq(wishlist_by_link)
      end
    end

    context 'when user requests hidden wishlist' do
      let!(:result) { operation.call({ id: wishlist_hidden.id }, user) }

      it 'returns wishlist' do
        expect(result.success?).to be_truthy
        expect(result.value!).to eq(wishlist_hidden)
      end
    end

    context 'when guest requests listed wishlist' do
      let!(:result) { operation.call({ id: wishlist_listed.id }, guest) }

      it 'returns wishlist' do
        expect(result.success?).to be_truthy
        expect(result.value!).to eq(wishlist_listed)
      end
    end

    context 'when guest requests by_link wishlist' do
      let!(:result) { operation.call({ id: wishlist_by_link.id }, guest) }

      it 'returns wishlist' do
        expect(result.success?).to be_truthy
        expect(result.value!).to eq(wishlist_by_link)
      end
    end

    context 'when anonymous requests listed wishlist' do
      let!(:result) { operation.call({ id: wishlist_listed.id }, anonymous) }

      it 'returns wishlist' do
        expect(result.success?).to be_truthy
        expect(result.value!).to eq(wishlist_listed)
      end
    end

    context 'when anonymous requests by_link wishlist' do
      let!(:result) { operation.call({ id: wishlist_by_link.id }, anonymous) }

      it 'returns wishlist' do
        expect(result.success?).to be_truthy
        expect(result.value!).to eq(wishlist_by_link)
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
    end

    context 'when param values are invalid' do
      let!(:result) { operation.call({ id: 'fake-id' }, user) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:id])
        expect(result.failure[1].errors.messages[0].text).to eq('not found')
      end
    end

    context 'when guest requests hidden wishlist' do
      let!(:result) { operation.call({ id: wishlist_hidden.id }, guest) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:id])
        expect(result.failure[1].errors.messages[0].text).to eq('not found')
      end
    end

    context 'when anonymous requests hidden wishlist' do
      let!(:result) { operation.call({ id: wishlist_hidden.id }, anonymous) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:id])
        expect(result.failure[1].errors.messages[0].text).to eq('not found')
      end
    end
  end
end
