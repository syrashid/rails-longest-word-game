require "application_system_test_case"

require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "Filling in the form with gibberish should return the word is not in the grid" do
    visit new_url
    fill_in "word", with: "zzzzzz"
    click_on "Submit"

    assert_text "Sorry but zzzzzz does not seem to be a valid English word..."
  end

  test "Filling in the form with a valid english word should return the unbuildable message" do
    visit new_url
    fill_in "word", with: "crackerjack"
    click_on "Submit"

    assert_text "Sorry but crackerjack can't be built out of "
  end

  test "Filling in the form with a valid english word in the grid should return congrats message" do
    visit new_url
    within("//li[@id='letter']") do
      fill_in 'Name', :with => 'Jimmy'
    end
    fill_in "word", with: "A"
    click_on "Submit"

    assert_text "Congratulations! A is a valid English word!"
    take_screenshot
  end
end
