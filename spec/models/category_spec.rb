require 'rails_helper'

RSpec.describe Category, :type => :model do
  it { is_expected.to have_many(:tasks).dependent(:destroy) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:description) }
end