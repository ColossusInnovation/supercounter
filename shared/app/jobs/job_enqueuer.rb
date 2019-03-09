class JobEnqueuer
  def self.increment_counter(id)
    Sidekiq::Client.push('class' => "CounterIncrementAsyncJob", 'args' => [id])
  end
end