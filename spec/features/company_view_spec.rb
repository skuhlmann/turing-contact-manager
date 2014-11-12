require 'rails_helper'

describe 'phone numbers', type: :feature do 
  describe 'the company view', type: :feature do 

    let(:company) {Company.create(name: "Burger King")}

    before(:each) do 
      company.phone_numbers.create(number: "555-1234")
      company.phone_numbers.create(number: "555-9876")
      visit company_path(company)
    end

    it "shows the phone numbers" do 
      company.phone_numbers.each do |phone|
        expect(page).to have_content(phone.number)
      end
    end

    it 'has a link to add a new phone number' do
      expect(page).to have_link('Add phone number', href: new_phone_number_path(contact_id: company.id, contact_type: 'Company'))
    end

    it "adds a new phone number" do 
      page.click_link('Add phone number')
      page.fill_in('Number', with: '555-8888')
      page.click_button('Create Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-8888')
    end

    it 'has links to edit phone numbers' do 
      company.phone_numbers.each do |phone|
        expect(page).to have_link('edit', href: edit_phone_number_path(phone))
      end
    end

    it "edits a phone number" do 
      phone = company.phone_numbers.first
      old_number = phone.number 

      first(:link, 'edit').click 
      page.fill_in('Number', with: '555-9191')
      page.click_button('Update Phone number')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9191')
      expect(page).not_to have_content(old_number)
    end

    it 'has links to delete phone numbers' do 
      company.phone_numbers.each do |phone|
        expect(page).to have_link('delete', href: phone_number_path(phone))
      end
    end

    it 'delete a phone number' do 
      number = company.phone_numbers.first

      first(:link, 'delete').click 
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('555-9876')
      expect(page).not_to have_content(number)
    end
  end
end

describe 'email addresses', type: :feature do 
  describe 'the company view', type: :feature do 

    let(:company) {Company.create(name: "Taco John's")}

    before(:each) do 
      company.email_addresses.create(address: "jim@jones.com")
      company.email_addresses.create(address: "mail@test.com")
      visit company_path(company)
    end

    it "shows the email address" do 
      company.email_addresses.each do |email|
        expect(page).to have_selector('li', text: email.address)
      end
    end

    it 'has a link to add a new email address' do
      expect(page).to have_link('Add email address', href: new_email_address_path(contact_id: company.id, contact_type: 'Company'))
    end

    it 'add a new email address' do 
      page.click_link('Add email address')
      page.fill_in('Address', with: 'new@email.com')
      page.click_button('Create Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('new@email.com')
    end

    it 'has links to edit email addresses' do 
      company.email_addresses.each do |address|
        expect(page).to have_link('edit', href: edit_email_address_path(address))
      end
    end

    it 'edits an email address' do 
      page.find_link('edit', href: edit_email_address_path(company.email_addresses.first.id)).click
      page.fill_in('Address', with: 'edited.email.com')
      page.click_button('Update Email address')
      expect(current_path).to eq(company_path(company))
      expect(page).to have_content('edited.email.com')
    end

    it 'has links to delete email addresses' do 
      company.email_addresses.each do |address| 
        expect(page).to have_link('delete', href: email_address_path(address))
      end
    end 

    it 'deletes an email address' do 
      page.find_link('delete', href: email_address_path(company.email_addresses.first.id)).click
      expect(current_path).to eq(company_path(company))
      expect(page).not_to have_content("jim@jones.com")
      expect(page).to have_content("mail@test.com")
    end 
  end
end





