require 'rails_helper'

RSpec.describe CountersController, type: :controller do

  context "GET index" do
    it "should have a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "should return application/json content type" do
      get :index
      expect(response.content_type).to eq("application/json")
    end

    context "when counters exist" do
      before :each do
        Counter.create!(:name => "TestCounter")
      end

      it "should return a non-empty JSON array" do
        get :index
        expect(response.body).to_not eq("[]")
      end

    end

    context "when no counters exist" do
      it "should return an empty JSON array" do
        get :index
        expect(response.body).to eq("[]")
      end
    end
  end

  context "POST create" do
    it "should have a 201 status code" do
      post :create, :params => {:counter => {:name => "TestCounter"}, :format => :json}
      expect(response.status).to eq(201)
    end

    it "should create a new counter" do
      post :create, :params => {:counter => {:name => "TestCounter"}, :format => :json}
      expect(Counter.count).to eq(1)
    end

    context "when the input is invalid" do
      it "should return an error" do
        post :create, :params => {:counter => {:totally_wrong_param => "TestCounter"}, :format => :json}
        expect(response.status).to eq(400)
      end
    end
  end

  context "GET increment" do
    let(:counter) {Counter.create!(:name => "TestCounter")}

    it "should increment the counter synchronously" do
      get :increment, :params => {:id => counter.id}
      counter.reload
      expect(counter.count).to eq(1)
    end

    context "when trying to increment a missing counter" do
      it "should return an error" do
        get :increment, :params => {:id => "not_a_real_id"}
        expect(response.status).to eq(404)
      end
    end
  end

  context "GET increment_async" do
    let(:counter) {Counter.create!(:name => "TestCounter")}

    it "should not increment the counter synchronously" do
      get :increment_async, :params => {:id => counter.id}
      counter.reload
      expect(counter.count).to eq(0)
    end

    it "should schedule a job to asychronously increment the counter" do
      expect(JobEnqueuer).to receive(:increment_counter).with(counter.id)
      get :increment_async, :params => {:id => counter.id}
    end

    context "when trying to increment a missing counter" do
      it "should return an error" do
        get :increment, :params => {:id => "not_a_real_id"}
        expect(response.status).to eq(404)
      end
    end
  end

end
