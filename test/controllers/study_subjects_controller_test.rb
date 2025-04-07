require "test_helper"

class StudySubjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get study_subjects_index_url
    assert_response :success
  end

  test "should get new" do
    get study_subjects_new_url
    assert_response :success
  end

  test "should get create" do
    get study_subjects_create_url
    assert_response :success
  end

  test "should get edit" do
    get study_subjects_edit_url
    assert_response :success
  end

  test "should get update" do
    get study_subjects_update_url
    assert_response :success
  end

  test "should get destroy" do
    get study_subjects_destroy_url
    assert_response :success
  end
end
