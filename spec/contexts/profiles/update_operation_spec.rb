# frozen_string_literal: true

RSpec.describe Profiles::UpdateOperation do
  subject(:operation) { described_class.new }

  let(:profile) { create(:profile, username: nil, display_name: nil) }
  let(:username) { Faker::Internet.username(specifier: 6) }
  let(:display_name) { Faker::Name.name }

  describe 'success' do
    context 'when params are correct' do
      let!(:result) { operation.call({ username:, display_name: }, profile.user) }

      it 'returns updated profile' do
        expect(result.success?).to be_truthy
        expect(result.value!).to eq(profile)
      end

      it 'updates the profile' do
        new_profile = Profile.find(profile.id)
        expect(new_profile.username).to eq(username)
        expect(new_profile.display_name).to eq(display_name)
      end
    end

    context 'when params are correct and display name is blank' do
      let!(:result) { operation.call({ username:, display_name: nil }, profile.user) }

      it 'returns updated profile' do
        expect(result.success?).to be_truthy
        expect(result.value!).to eq(profile)
      end

      it 'updates the profile and sets username to display name' do
        new_profile = Profile.find(profile.id)
        expect(new_profile.username).to eq(username)
        expect(new_profile.display_name).to eq(username)
      end
    end
  end

  describe 'failure' do
    context 'when params are not filled' do
      let!(:result) { operation.call({ username: nil, display_name: nil }, profile.user) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:username])
        expect(result.failure[1].errors.messages[0].text).to eq('must be filled')
      end

      it 'does not update the profile' do
        new_profile = Profile.find(profile.id)
        expect(new_profile.username).to eq(profile.username)
        expect(new_profile.display_name).to eq(profile.display_name)
      end
    end

    context 'when param values are too short' do
      let!(:result) { operation.call({ username: '1', display_name: '1' }, profile.user) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:username])
        expect(result.failure[1].errors.messages[0].text).to eq('size cannot be less than 6')

        expect(result.failure[1].errors.messages[1].path).to eq([:display_name])
        expect(result.failure[1].errors.messages[1].text).to eq('size cannot be less than 2')
      end

      it 'does not update the profile' do
        new_profile = Profile.find(profile.id)
        expect(new_profile.username).to eq(profile.username)
        expect(new_profile.display_name).to eq(profile.display_name)
      end
    end

    context 'when param values are too long' do
      let!(:result) { operation.call({ username: Faker::Internet.username(specifier: 255), display_name: Faker::Lorem.paragraph_by_chars }, profile.user) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:username])
        expect(result.failure[1].errors.messages[0].text).to eq('size cannot be greater than 255')

        expect(result.failure[1].errors.messages[1].path).to eq([:display_name])
        expect(result.failure[1].errors.messages[1].text).to eq('size cannot be greater than 255')
      end

      it 'does not update the profile' do
        new_profile = Profile.find(profile.id)
        expect(new_profile.username).to eq(profile.username)
        expect(new_profile.display_name).to eq(profile.display_name)
      end
    end

    context 'when username has already been used' do
      let(:profile) { create(:profile) }
      let(:profile_new) { create(:profile) }
      let!(:result) { operation.call({ username: profile.username, display_name: }, profile_new.user) }

      it 'returns failure messages' do
        expect(result.failure?).to be_truthy
        expect(result.failure[0]).to eq(:not_valid)

        expect(result.failure[1].errors.messages[0].path).to eq([:username])
        expect(result.failure[1].errors.messages[0].text).to eq('must be unique')
      end

      it 'does not update the profile' do
        new_profile = Profile.find(profile_new.id)
        expect(new_profile.username).to eq(profile_new.username)
        expect(new_profile.display_name).to eq(profile_new.display_name)
      end
    end
  end
end
