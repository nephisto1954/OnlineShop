require 'rails_helper'

RSpec.describe Product, type: :model do
  subject { described_class.new(title: "Anything", description: "Lorem Ipsum") }

  it "is not valid without a title" do
    subject.title = nil
    expect(subject).not_to be_valid
  end

  it "is not valid without a description" do
    subject.description = nil
    expect(subject).not_to be_valid
  end

end
