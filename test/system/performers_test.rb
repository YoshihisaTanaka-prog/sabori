require "application_system_test_case"

class PerformersTest < ApplicationSystemTestCase
  setup do
    @performer = performers(:one)
  end

  test "visiting the index" do
    visit performers_url
    assert_selector "h1", text: "Performers"
  end

  test "creating a Performer" do
    visit performers_url
    click_on "New Performer"

    fill_in "Event", with: @performer.event_id
    fill_in "Firstname", with: @performer.firstname
    fill_in "Lastname", with: @performer.lastname
    fill_in "Organization", with: @performer.organization
    fill_in "Role", with: @performer.role
    click_on "Create Performer"

    assert_text "Performer was successfully created"
    click_on "Back"
  end

  test "updating a Performer" do
    visit performers_url
    click_on "Edit", match: :first

    fill_in "Event", with: @performer.event_id
    fill_in "Firstname", with: @performer.firstname
    fill_in "Lastname", with: @performer.lastname
    fill_in "Organization", with: @performer.organization
    fill_in "Role", with: @performer.role
    click_on "Update Performer"

    assert_text "Performer was successfully updated"
    click_on "Back"
  end

  test "destroying a Performer" do
    visit performers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Performer was successfully destroyed"
  end
end
