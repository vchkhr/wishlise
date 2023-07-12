# frozen_string_literal: true

RSpec.describe Profiles::UpdateAvatarOperation do
  subject(:operation) { described_class.new }

  let(:profile) { create(:profile) }
  let(:avatar) { fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-avatar.png'), 'image/png') }

  describe 'success' do
    context 'when params are correct' do
      let!(:result) { operation.call({ avatar: }, profile.user) }

      it 'returns updated profile' do
        expect(result.success?).to be_truthy
        expect(result.value!.avatar).to be_attached
        expect(result.value!.avatar.present?).to be_truthy
        expect(result.value!.avatar.filename).to eq('test-avatar.png')
      end

      it 'updates the profile' do
        new_profile = Profile.find(profile.id)
        expect(ActiveStorage::Attachment.count).to eq(1)
        expect(new_profile.avatar).to be_attached
        expect(new_profile.avatar.present?).to be_truthy
        expect(new_profile.avatar.filename).to eq('test-avatar.png')
      end
    end

    context 'when removing avatar' do
      let(:profile_with_avatar) { create(:profile, :with_avatar) }
      let!(:result) { operation.call({ avatar: nil }, profile_with_avatar.user) }

      it 'returns updated profile' do
        expect(result.success?).to be_truthy
        expect(result.value!.avatar.present?).to be_falsy
        expect(result.value!.avatar.filename).to be_nil
      end

      it 'updates the profile' do
        new_profile = Profile.find(profile_with_avatar.id)
        expect(ActiveStorage::Attachment.count).to eq(0)
        expect(new_profile.avatar.present?).to be_falsy
        expect(new_profile.avatar.filename).to be_nil
      end
    end
  end

  describe 'failure' do
    context 'when param values are incorrect' do
      let!(:result) { operation.call({ avatar: fixture_file_upload(Rails.root.join('spec', 'support', 'assets', 'test-pdf.pdf'), 'application/pdf') }, profile.user) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:avatar])
        expect(result.failure[1].errors.messages[0].text).to eq('must be a JPEG or PNG image')
      end

      it 'does not update the profile' do
        new_profile = Profile.find(profile.id)
        expect(ActiveStorage::Attachment.count).to eq(0)
        expect(new_profile.avatar.present?).to be_falsy
        expect(new_profile.avatar.filename).to be_nil
      end
    end
  end
end
