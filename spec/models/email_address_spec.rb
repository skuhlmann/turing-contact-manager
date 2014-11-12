require 'rails_helper'

RSpec.describe EmailAddress, :type => :model do
  let(:email_address) {EmailAddress.new(address: "sam@test.com", contact_id: 2, contact_type: "Company")}

  it "is valid" do
    expect(email_address).to be_valid
  end

  it "is invalid without an email" do 
    email_address.address = nil
    expect(email_address).to_not be_valid
  end

  it "must have a reference to a contact" do 
    email_address.contact_id = nil
    expect(email_address).to_not be_valid
  end

  it 'is associated with a contact' do 
    expect(email_address).to respond_to(:contact)
  end
end
