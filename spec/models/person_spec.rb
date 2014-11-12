require 'rails_helper'

RSpec.describe Person, :type => :model do
  let(:person) do 
    Person.new(first_name: "Molly", last_name: "Bloom")
  end

  it "is valid" do 
    expect(person).to be_valid
  end

  it 'is invalid without a first name' do 
    person.first_name = nil
    expect(person).not_to be_valid
  end

  it 'is invalid without a last name' do 
    person.last_name = nil
    expect(person).not_to be_valid
  end

  it 'has an array of phone numbers' do 
    person.phone_numbers.build(number: '555-8888')
    expect(person.phone_numbers.map(&:number)).to eq(['555-8888'])
  end

  it 'has an array of emails' do 
    person.email_addresses.build(address: "tacos@taco.com")
    expect(person.email_addresses.map(&:address)).to eq(["tacos@taco.com"])
  end
end
