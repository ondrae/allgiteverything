require "rails_helper"

RSpec.describe CollectionsController, type: :routing do
  describe "routing" do

    it "/slug goes works too" do
      create :collection, slug: "TEST-COLLECTION"
      expect(get: "/TEST-COLLECTION").to route_to "collections#show", id: "TEST-COLLECTION"
    end

    it "routes to #index" do
      expect(:get => "/collections").to route_to("collections#index")
    end

    it "routes to #new" do
      expect(:get => "/collections/new").to route_to("collections#new")
    end

    it "routes to #show" do
      expect(:get => "/collections/test-collection").to route_to("collections#show", :id => "test-collection")
      expect(:get => "/collections/1").to route_to("collections#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/collections/1/edit").to route_to("collections#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/collections").to route_to("collections#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/collections/1").to route_to("collections#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/collections/1").to route_to("collections#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/collections/1").to route_to("collections#destroy", :id => "1")
    end

    it "routes to #issues" do
      expect(:get => "/collections/1/issues").to route_to("issues#index", :collection_id => "1")
    end

    it "routes to #embed" do
      expect(get: "/collections/test-collection/embed").to route_to("collections#embed", :id => "test-collection")
    end

  end
end
