feature 'Viewing links' do

  scenario 'I can see existing links on the links page' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')

    visit '/links'
    # as this is the first feauture test, the following expectation is a quick
    # check that everything is working
    expect(page.status_code).to eql(200)
    # might remove this later
    within 'ul#links' do
      expect(page).to have_content('Makers Academy')
    end
  end
end
