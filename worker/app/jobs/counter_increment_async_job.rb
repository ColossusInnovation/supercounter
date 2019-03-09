class CounterIncrementAsyncJob
  include Sidekiq::Worker

  def perform(id)
    @counter = Counter.find(id)
    if @counter
      @counter.increment!
    end
  end
end
