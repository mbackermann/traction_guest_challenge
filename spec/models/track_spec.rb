require 'rails_helper'

RSpec.describe Track, type: :model do
  subject {
    described_class.new(room: Room.new, guest: Guest.new, status: 'Entered')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it { should belong_to(:guest) }
  it { should belong_to(:room) }
  it "is not valid without a status" do
    subject.status = nil
    expect(subject).to_not be_valid
  end
end
