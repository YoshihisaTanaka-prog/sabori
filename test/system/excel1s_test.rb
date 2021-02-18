require "application_system_test_case"

class Excel1sTest < ApplicationSystemTestCase
  setup do
    @excel1 = excel1s(:one)
  end

  test "visiting the index" do
    visit excel1s_url
    assert_selector "h1", text: "Excel1s"
  end

  test "creating a Excel1" do
    visit excel1s_url
    click_on "New Excel1"

    fill_in "Body", with: @excel1.body
    fill_in "Title", with: @excel1.title
    click_on "Create Excel1"

    assert_text "Excel1 was successfully created"
    click_on "Back"
  end

  test "updating a Excel1" do
    visit excel1s_url
    click_on "Edit", match: :first

    fill_in "Body", with: @excel1.body
    fill_in "Title", with: @excel1.title
    click_on "Update Excel1"

    assert_text "Excel1 was successfully updated"
    click_on "Back"
  end

  test "destroying a Excel1" do
    visit excel1s_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Excel1 was successfully destroyed"
  end
end
