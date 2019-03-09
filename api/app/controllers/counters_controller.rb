class CountersController < ApplicationController
  def index
    @counters = Counter.all
    render json: @counters, status: :ok
  end

  def create
    @counter = Counter.create!(counter_params)
    render json: @counter, status: :created
  end

  def increment
    @counter = Counter.find(params[:id])
    @counter.increment!
    render json: @counter, status: :ok
  end

  def increment_async
    @counter = Counter.find(params[:id])
    JobEnqueuer.increment_counter(@counter.id.to_s)
    render json: @counter, status: :ok
  end

  private

  def counter_params
    params.require(:counter).permit(:name)
  end
end
