require 'rails_helper'

RSpec.describe CounterIncrementAsyncJob, type: :job do
  let(:counter){Counter.create!(:name => "TestCounter")}

  it "should increment a counter if it exists" do
    CounterIncrementAsyncJob.new.perform(counter.id)
    counter.reload
    expect(counter.count).to eq(1)
  end

  it "should not raise an error if the counter doesn't exist" do
    expect{CounterIncrementAsyncJob.new.perform(counter.id)}.not_to raise_error
  end
end
