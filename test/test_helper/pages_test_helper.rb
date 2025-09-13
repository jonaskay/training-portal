module PagesTestHelper
  def visit_root_path
    visit root_path
    assert_title "Training Portal"
  end
end
