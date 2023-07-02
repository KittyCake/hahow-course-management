require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should belong_to(:instructor) }
  it { should have_many(:chapters).dependent(:destroy) }

  it { should validate_presence_of(:name) }
end
