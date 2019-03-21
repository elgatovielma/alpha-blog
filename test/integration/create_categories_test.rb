require 'test_helper'

#testing all at once
class CreateCategoriesTest < ActionDispatch::IntegrationTest

    def setup
        @user = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
    end
    
    test "get new category form and create category" do
        sign_in_as(@user, "password")
        get new_category_path
        assert_template 'categories/new'
        #Simulating a post to put a new category
        assert_difference 'Category.count', 1 do
            post categories_path, params:{ category: {name: "sports"} }
            follow_redirect!
        end
        assert_template 'categories/index'
        assert_match "sports", response.body
    end

    test "invalid category submission results in failure" do 
        sign_in_as(@user, "password")
        get new_category_path
        assert_template 'categories/new'
        #Simulating a post to put a new category
        assert_no_difference 'Category.count' do
            post categories_path, params:{ category: {name: " "} }
        end
        assert_template 'categories/new'
        assert_select 'h2.panel-title'
        assert_select 'div.panel-body'
    end

end