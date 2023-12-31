require 'rails_helper'

RSpec.describe Instructor, type: :model do
  it { should have_many(:courses).dependent(:destroy) }

  it { should validate_presence_of(:name) }
end
