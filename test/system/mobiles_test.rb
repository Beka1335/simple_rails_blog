# frozen_string_literal: true

require 'application_system_test_case'

class MobilesTest < ApplicationSystemTestCase
  setup do
    @mobile = mobiles(:one)
  end

  test 'visiting the index' do
    visit mobiles_url
    assert_selector 'h1', text: 'Mobiles'
  end

  test 'should create mobile' do
    visit mobiles_url
    click_on 'New mobile'

    click_on 'Create Mobile'

    assert_text 'Mobile was successfully created'
    click_on 'Back'
  end

  test 'should update Mobile' do
    visit mobile_url(@mobile)
    click_on 'Edit this mobile', match: :first

    click_on 'Update Mobile'

    assert_text 'Mobile was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Mobile' do
    visit mobile_url(@mobile)
    click_on 'Destroy this mobile', match: :first

    assert_text 'Mobile was successfully destroyed'
  end
end
