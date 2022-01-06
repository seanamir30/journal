require 'rails_helper'

RSpec.describe 'Category', type: :feature do
    before(:each) do
        @user = create(:user) 
        @category = create(:category, user: @user)
        @marked_task = create(:task, :marked, category: @category)
        @unmarked_task = create(:task, :unmarked, category: @category)
        @marked_today = create(:task, :today, :marked, category: @category)
        @unmarked_today = create(:task, :today, :unmarked, category: @category)
        login(@user)
    end

    describe 'Create' do
      let!(:new_category) {
        Category.new(
          user: @user,
          title: "Projects",
          description: 'This is a sample category.'
        )
      }

      it 'shows the new category page' do
        visit new_category_path
        expect(page).to have_content('Create a Category')
      end

      it 'should display a notice when title is blank' do
        visit new_category_path
        fill_in('Description', :with => new_category.description)
        click_on('Submit')
        
        expect(page).to have_content("Title can't be blank")
      end

      it 'should display a notice when description is blank' do
        visit new_category_path
        fill_in('Title', :with => new_category.title)
        click_on('Submit')
        
        expect(page).to have_content("Description can't be blank")
      end

      it 'should redirect to category on successful creation' do
        visit new_category_path
        fill_in('Title', :with => new_category.title)
        fill_in('Description', :with => new_category.description)
        click_on('Submit')
        
        expect(page).to have_current_path(categories_path)
        expect(page).to have_content(new_category.title)
      end
    end

    describe 'Update' do
        let!(:updated_category) {
          Category.new(
            user: @user,
            title: "Updated Category",
            description: 'This is a sample updated category.'
          )
        }

        it 'shows the edit category page' do
          visit edit_category_path(@category)
          expect(page).to have_content('Edit a Category')
        end
    
        it 'should display a notice when title is blank' do
          visit edit_category_path(@category)
          fill_in('Title', :with => "")
          fill_in('Description', :with => updated_category.description)
          click_on('Submit')
          
          expect(page).to have_content("Title can't be blank")
        end
    
        it 'should display a notice when description is blank' do
          visit edit_category_path(@category)
          fill_in('Title', :with => updated_category.title)
          fill_in('Description', :with => "")
          click_on('Submit')
          
          expect(page).to have_content("Description can't be blank")
        end
    
        it 'should redirect to categories on successful update' do
          visit edit_category_path(@category)
          fill_in('Title', :with => updated_category.title)
          fill_in('Description', :with => updated_category.description)
          click_on('Submit')
          
          expect(page).to have_current_path(categories_path)
          expect(page).to have_content(updated_category.title)
        end
    end

    describe 'View' do
      it 'shows the category and displays the tasks within' do
        visit category_path(@category)
        expect(page).to have_content(@category.title)
        expect(page).to have_content(@marked_task.title)
        expect(page).to have_content(@unmarked_task.title)
      end
    end

end