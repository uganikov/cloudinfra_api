class Instance < ApplicationRecord
  generate_public_uid

  def to_param
    "i-#{public_uid}"
  end

  def to_key
    ["i-#{public_uid}"]
  end
end
