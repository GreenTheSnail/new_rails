require 'test_helper'

class TagAssociationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tag_association = tag_associations(:one)
  end

  test "should get index" do
    get tag_associations_url
    assert_response :success
  end

  test "should get new" do
    get new_tag_association_url
    assert_response :success
  end

  test "should create tag_association" do
    assert_difference('TagAssociation.count') do
      post tag_associations_url, params: { tag_association: {  } }
    end

    assert_redirected_to tag_association_url(TagAssociation.last)
  end

  test "should show tag_association" do
    get tag_association_url(@tag_association)
    assert_response :success
  end

  test "should get edit" do
    get edit_tag_association_url(@tag_association)
    assert_response :success
  end

  test "should update tag_association" do
    patch tag_association_url(@tag_association), params: { tag_association: {  } }
    assert_redirected_to tag_association_url(@tag_association)
  end

  test "should destroy tag_association" do
    assert_difference('TagAssociation.count', -1) do
      delete tag_association_url(@tag_association)
    end

    assert_redirected_to tag_associations_url
  end
end
