class Transform < ActiveRecord::Base
  belongs_to :phrase
  belongs_to :transformation, :class_name => "Phrase"
end
