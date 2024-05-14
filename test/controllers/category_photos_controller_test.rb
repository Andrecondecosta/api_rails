require "test_helper"

class CategoryPhotosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category_photo = category_photos(:one)
  end

  test "should get index" do
    get category_photos_url, as: :json
    assert_response :success
  end

  test "should create category_photo" do
    assert_difference("CategoryPhoto.count") do
      post category_photos_url, params: { category_photo: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show category_photo" do
    get category_photo_url(@category_photo), as: :json
    assert_response :success
  end

  test "should update category_photo" do
    patch category_photo_url(@category_photo), params: { category_photo: {  } }, as: :json
    assert_response :success
  end

  test "should destroy category_photo" do
    assert_difference("CategoryPhoto.count", -1) do
      delete category_photo_url(@category_photo), as: :json
    end

    assert_response :no_content
  end
end
