require 'rails_helper'

RSpec.describe Guest, type: :model do
  subject {
    described_class.new(first_name: "Rafael", last_name: "Silva",
                        email: "rafaelsilva@gmail.com", document_id: "1234567")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a first name" do
    subject.first_name = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a last name" do
    subject.last_name = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a email name" do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  it "is not valid if email already exists" do
    Guest.create(subject.attributes)
    expect(subject).to_not be_valid
  end

  it { should have_many(:tracks).dependent(:destroy) }
end
