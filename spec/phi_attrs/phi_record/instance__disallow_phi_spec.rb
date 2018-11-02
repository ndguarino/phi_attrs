# frozen_string_literal: true

RSpec.describe 'instance disallow_phi' do
  file_name = __FILE__

  let(:patient_john) { build(:patient_info, first_name: 'John') }

  context 'block', skip: 'Not yet implemented' do
    it 'disables all allowances within the block' do |t|
      patient_john.allow_phi!(file_name, t.full_description)
      expect { patient_john.first_name }.not_to raise_error

      patient_john.disallow_phi do
        expect { patient_john.last_name }.to raise_error(access_error)
      end
    end

    it 'returns permission after the block' do |t|
      patient_john.allow_phi!(file_name, t.full_description)
      expect { patient_john.first_name }.not_to raise_error

      patient_john.disallow_phi do
        expect { patient_john.first_name }.to raise_error(access_error)
      end

      expect { patient_john.first_name }.not_to raise_error
    end
  end

  context 'disallow_phi!' do
    it 'disallows whole stack' do |t|
      patient_john.allow_phi!(file_name + '1', t.full_description)
      expect { patient_john.first_name }.not_to raise_error
      patient_john.allow_phi!(file_name + '2', t.full_description)
      expect { patient_john.first_name }.not_to raise_error
      patient_john.disallow_phi!
      expect { patient_john.first_name }.to raise_error(access_error)
    end

    it 'disallows does not affect Class allows' do |t|
      PatientInfo.allow_phi!(file_name, t.full_description)
      expect { patient_john.first_name }.not_to raise_error
      patient_john.allow_phi!(file_name + '2', t.full_description)
      expect { patient_john.first_name }.not_to raise_error
      patient_john.disallow_phi!
      expect { patient_john.first_name }.not_to raise_error
    end

    it 'allows access after disallow' do |t|
      patient_john.allow_phi!(file_name + '1', t.full_description)
      expect { patient_john.first_name }.not_to raise_error
      patient_john.disallow_phi!
      expect { patient_john.first_name }.to raise_error(access_error)
      patient_john.allow_phi!(file_name + '2', t.full_description)
      expect { patient_john.first_name }.not_to raise_error
    end
  end
end
