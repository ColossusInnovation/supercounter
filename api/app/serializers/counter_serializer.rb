class CounterSerializer < ActiveModel::Serializer
  attribute :id do
    object.id.to_s
  end

  attributes :name, :count
end