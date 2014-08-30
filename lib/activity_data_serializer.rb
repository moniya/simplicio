class ActivityDataSerializer
  def load(data)
    JSON.parse(data) rescue data
  end

  def dump(obj)
    obj.to_json
  end
end
