class Programmer < ActiveRecord::Base
  has_many :programmer_technologies
  has_many :technologies, through: :programmer_technologies

  validates :programmer, presence: true
  validates :experience, presence: true, numericality: { only_integer: true }
  validates :is_senior, presence: true
  validates :friend_id, numericality: { only_integer: true }

  def p_programmers
    technologies = Technology.where("technology LIKE (?) OR technology LIKE (?)", "#{"p"}%", "%#{"e"}%")

    programmers = []
    technologies.each do |tech|
      tech.programmers.each do |prog|
         programmers << prog.programmer
      end
    end
    return programmers
  end


end
