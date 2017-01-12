class ProgrammerTechnology < ActiveRecord::Base
  belongs_to :programmer
  belongs_to :technology

end
