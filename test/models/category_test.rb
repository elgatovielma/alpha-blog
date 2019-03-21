require 'test_helper'

# test Model
class CategoryTest < ActiveSupport::TestCase

    # setup runs before the tests
    # The data is stored in a test DB, therefore it will clean itself
    # after the tests
    def setup
        @category = Category.new(name: "sports")
    end

    test "category should be valid" do
        assert @category.valid?
    end

    test "name should be present" do
        @category.name = " "
        # testing this is not valid (leaving the name empty)
        assert_not @category.valid?
    end

    test "name should be unique" do
        @category.save
        category2 = Category.new(name: "sports")
        assert_not category2.valid?
    end

    test "should be not be too long" do
        @category.name = "a" * 26
        assert_not @category.valid?
    end

    test "name should not be too short" do
        @category.name = "aa"  
        assert_not @category.valid?
    end

end