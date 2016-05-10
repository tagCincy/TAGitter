module RequestUtils

  def json
    JSON.parse(response.body, { symbolize_names: true })
  end

  def returned_ids
    json.map { |p| p[:id] }
  end
end