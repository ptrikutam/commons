class CreateNewResourceRecord
  def write(attributes)
    ap attributes.keys
    # From within a rake task, you have the Rails Env so you can call:
    # record = ActiveModel::Resource.create!(attributes)
  end
end
