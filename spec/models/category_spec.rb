require 'rails_helper'

RSpec.describe Category, type: :model do
  subject { described_class.new(name: "Anything") }

  it "is not valid without a name" do
    subject.name = nil
    expect(subject).not_to be_valid
  end

end
