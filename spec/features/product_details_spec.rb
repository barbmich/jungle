require 'rails_helper'

RSpec.feature "ProductDetails", type: :feature, js: true do

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

  scenario "They see product1 page" do
    # ACT
    visit root_path
    sleep(1)
    first(:link, 'Details').click
    sleep(1)
    # DEBUG
    save_screenshot("visit_product1_page.png")

    # VERIFY
    expect(page).to have_css '.product-detail', count: 1
  end
end
