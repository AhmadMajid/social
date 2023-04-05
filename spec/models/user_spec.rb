require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:vibrations).dependent(:destroy) }
  it { should validate_uniqueness_of(:username).case_insensitive.allow_blank }
end
