require 'rails_helper'

RSpec.feature "AddToCarts", type: :feature, js: true do
# SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "A product is added to the cart" do
    # ACT
    visit root_path
    click_button('Add', match: :first)

    # DEBUG
    save_screenshot("Item_added_to_cart.png")

    expect(page).to have_text 'My Cart (1)'
  end

  scenario "A product is added to the cart" do
    # ACT
    visit root_path
    click_button('Add', match: :first)
    click_on 'My Cart'

    # DEBUG
    save_screenshot("visit_Mycart_page.png")

    # VERIFY
    expect(page).to have_css '.table'
  end

end
