require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
	# for devise authentication
	login_user

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  it "should get index" do
    get 'index'
    response.should be_success
  end

	before(:all) do
		@recipe_1 = Recipe.create(tittle: 'tittle_1', instructions: 'instructions_1')
		@recipe_2 = Recipe.create(tittle: 'tittle_2', instructions: 'instructions_2')
	end

	it "#index" do
		get :index
		expect(response).to have_http_status(200)
		expect(response).to render_template(:index)
	end

	it "#new" do
		get :new
		expect(response).to have_http_status(200)
		expect(response).to render_template(:new)
	end

	it "#edit" do
		get :edit, id: @recipe_1[:id]
		expect(response).to have_http_status(200)
		expect(response).to render_template(:edit)
	end

	describe "#create" do
	 
		before(:all) do
			@recipe_params = {tittle: 'tittle', instructions: 'instructions'}
		end

		it "creates record" do
			expect{ post :create, recipe: @recipe_params }.to change{Recipe.all.size}.by(1)
		end 	

		it "redirect on success" do
			post :create, recipe: @recipe_params
			expect(response).not_to have_http_status(200)
			expect(response).to have_http_status(302)
			expect(response).to redirect_to(recipe_path(Recipe.last))
		end

		it "render :new on fail" do
			allow_any_instance_of(Recipe).to receive(:save).and_return(false)
			post :create, recipe: @recipe_params
			expect(response).not_to have_http_status(302)
			expect(response).to render_template(:new)
		end			
	end

	describe "#update" do 
		before(:all) do
			@recipe_params = {tittle: 'tittle_3', instructions: 'instructions'}
		end

		it "change record" do
			post :update, recipe: @recipe_params, id: @recipe_2[:id]
			expect(response).not_to have_http_status(200)
			expect(response).to have_http_status(302)
			expect(response).to redirect_to(recipe_path(Recipe.find(@recipe_2[:id])))
		end

		it "redirect on success" do
			post :create, recipe: @recipe_params
			expect(response).not_to have_http_status(200)
			expect(response).to have_http_status(302)
			expect(response).to redirect_to(recipe_path(Recipe.last))
		end

		it "render :edit on fail" do
			allow_any_instance_of(Recipe).to receive(:update).and_return(false)
			post :update, recipe: @recipe_params, id: @recipe_2[:id]
			expect(response).not_to have_http_status(302)
			expect(response).to render_template(:edit)
		end	
	end

	describe "#destroy" do

		before(:each) do
			@recipe_3 = @recipe_2 || Recipe.create(tittle: "tittle_3", instructions: "instructions_3")
		end

		it "destroy record" do 
			expect{ delete :destroy, id: @recipe_3[:id] }.to change{Recipe.all.count}.by(-1)
		end

		it "redirect_to index after destroy" do
			delete :destroy, id: @recipe_3[:id]
			expect(response).not_to have_http_status(200)
			expect(response).to redirect_to(recipes_path)
		end
	end

end
