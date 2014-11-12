require 'rails_helper'

RSpec.describe Company, :type => :model do
  let(:company) {Company.new(name: "Burger King")}

  it 'is valid' do
    expect(company).to be_valid
  end

  it 'is invalid without a name' do 
    company.name = nil
    expect(company).not_to be_valid
  end

  it 'responds with a number after they are created' do 
    phone_number = company.phone_numbers.build(number: "333-2222")
    expect(phone_number.number).to eq("333-2222")
  end

end
