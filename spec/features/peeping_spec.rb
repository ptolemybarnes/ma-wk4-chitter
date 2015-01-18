feature 'user posts a peep' do

  scenario 'when user is logged in' do
    oz_the_user = create(:a_user, name: "Oz")
    signin_as oz_the_user

    visit '/peep/new'
    fill_in 'text', with: 'Hello, World'
    click_button "Peep away!"

    expect(page).to have_content('Hello, World')
    expect(page).to have_content('peeped by Oz')
  end
end

feature 'peeps are viewable' do

  scenario 'on the homepage' do
    peep  = "Colorless green ideas sleep furiously."
    simon = build_stubbed(:a_user, name: "Simon")
    create(:a_peep, text: peep, user: simon)

    visit '/'

    expect(page).to have_content(peep)
    expect(page).to have_content("by Simon")
  end

end

def signin_as user
  visit '/user/signin'

  fill_in 'name'                 , with: user.name
  fill_in 'password'             , with: user.password
  click_button 'Login'
end