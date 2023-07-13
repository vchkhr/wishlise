# frozen_string_literal: true

RSpec.describe Wishlists::IndexOperation do
  subject(:operation) { described_class.new }

  let(:author) { create(:user) }
  let(:user) { create(:user) }
  let(:guest) { nil }

  let(:wishlists_listed) { create_list(:wishlist, 3, publicity: 'listed', user: author) }
  let(:wishlists_by_link) { create_list(:wishlist, 3, publicity: 'by_link', user: author) }
  let(:wishlists_hidden) { create_list(:wishlist, 3, publicity: 'hidden', user: author) }

  describe 'success' do
    context 'when author requests listed wishlists' do
      let!(:result) { operation.call({}, author) }

      it 'returns wishlists' do
        expect(result.success?).to be_truthy
        expect(result.value!).to match_array(wishlists_listed)
      end
    end
  end

  describe 'failure' do
    # context 'when param values are empty' do
    #   let!(:result) { operation.call({ id: '' }, author) }

    #   it 'returns failure messages' do
    #     expect(result.failure?).to be_truthy
    #     expect(result.failure[0]).to eq(:not_valid)

    #     expect(result.failure[1].errors.messages[0].path).to eq([:id])
    #     expect(result.failure[1].errors.messages[0].text).to eq('must be filled')
    #   end
    # end

    # context 'when param values are invalid' do
    #   let!(:result) { operation.call({ id: 'fake-id' }, author) }

    #   it 'returns failure messages' do
    #     expect(result.failure?).to be_truthy
    #     expect(result.failure[0]).to eq(:not_valid)

    #     expect(result.failure[1].errors.messages[0].path).to eq([:id])
    #     expect(result.failure[1].errors.messages[0].text).to eq('not found')
    #   end
    # end

    # context 'when user requests hidden wishlists' do
    #   let!(:result) { operation.call({ id: wishlists_hidden.id }, user) }

    #   it 'returns failure messages' do
    #     expect(result.failure?).to be_truthy
    #     expect(result.failure[0]).to eq(:not_valid)

    #     expect(result.failure[1].errors.messages[0].path).to eq([:id])
    #     expect(result.failure[1].errors.messages[0].text).to eq('not found')
    #   end
    # end

    # context 'when guest requests hidden wishlists' do
    #   let!(:result) { operation.call({ id: wishlists_hidden.id }, guest) }

    #   it 'returns failure messages' do
    #     expect(result.failure?).to be_truthy
    #     expect(result.failure[0]).to eq(:not_valid)

    #     expect(result.failure[1].errors.messages[0].path).to eq([:id])
    #     expect(result.failure[1].errors.messages[0].text).to eq('not found')
    #   end
    # end
  end
end
