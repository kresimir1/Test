General Programming

1. Write a method in Ruby that, given an integer, will return the factorial of the integer.

# Using recursion
def factorial(num)
    if num <= 1
      1
    else
        num * factorial(num-1)
    end
end

# Using iteration
def iter_factorial(num)
  if num <= 1
    1
  else
    sum = 1
    num.times do |n|
      sum *= (n + 1)
    end
    sum
  end
end

2. What editor do you use?
Atom

3. Write a method in Ruby that, given any 2 strings, will return true if the first string is
contained in the second one, and false otherwise.

def str_includes(str1, str2)
  if str2.downcase.include?(str1.downcase)
    true
  else
    false
  end
end

4. What does this do:

`$=`;$_=\%!;($_)=/(.)/;$==++$|;($.,$/,$,,$\,$",$;,$^,$#,$~,$*,$:,@%)=(

$!=~/(.)(.).(.)(.)(.)(.)..(.)(.)(.)..(.)......(.)/,$"),$=++;$.++;$.++;

$_++;$_++;($_,$\,$,)=($~.$"."$;$/$%[$?]$_$\$,$:$%[$?]",$"&$~,$#,);$,++

;$,++;$^|=$";`$_$\$,$/$:$;$~$*$%[$?]$.$~$*${#}$%[$?]$;$\$&"$^$~$*.>&$=`

This seems to be a pearl regex which I am not familiar enough to solve this

5. Describe what each line of this class does.

class Admin
  cattr_accessor :tabs #Defines both class and instance accessors for class attributes.
    @@tabs = %w(users) #class variable @@tabs defined as ["users"]
    class << self #self refers to the object instance of the class;
    #any methods defined in the definition block become methods on the class object (and thus become class methods)
      def add_tab(tab) #defined 'add_tab' method with one argument 'tab'
        @@tabs = @@tabs | [tab] #this method checks if @@tabs array contains 'tab' and if not adds it to the array
        # in other words if this is an array of users - if a tab-user is new it adds him to the users
      end
      def tabs # defined method 'tabs'
        @@tabs.sort # it sorts the elements in the @@tabs (sorts users alphabetically)
      end
  end
end

6. What is the difference between strings and symbols? What is the best case to use each
one?
We use symbols as a means to identify unique sequences of characters.
Unlike strings once symbols are declared, they cannot be modified (immutable).
Though strings might be equal, they have different object ids. This is Ruby's way of telling us that they exist in two different memory places, or addresses. Therefore, they are two distinct things to our computer.
Equivalent symbols always exist in the same memory space, because they are always the same object! For this reason, symbols provide many speed and memory related performance benefits.
When we have a need to compare strings that will never change for the life of our programs, symbols provide the best, most performant option.

SQL and Rails
NOTE:
I noticed that in the joined (programmers_technologies) there is a technology id 8 and
there is only 7 listed in technologies table. Not sure if that was on purpose or a mistake
but it generates a foreign key constraint violation so I changed that value to null.
Also not all programmers have listed technologies in that table
(I decided to still list programmers name where there is combined search but no technology by using LEFT JOIN instead of JOIN)

1. Name of all senior programmers and the technology they use.

SELECT programmer, technology FROM programmers
LEFT JOIN  programmers_technologies
ON id = programmers_technologies.programmer_id
LEFT JOIN technologies
ON technologies.id = programmers_technologies.technology_id
WHERE is_senior = '1'
OR is_senior = 'true';

2. Name of each programmer whose technology start with “p” or contain an “e”.

SELECT programmer FROM programmers
FULL OUTER JOIN programmers_technologies
ON id = programmers_technologies.programmer_id
JOIN technologies
ON technologies.id = programmers_technologies.technology_id
WHERE technologies.technology LIKE 'p%'
OR technologies.technology LIKE '%e%';

3. Name of each programmer that has a friend and the name of that programmer’s friend.

SELECT programmer, friend FROM programmers
JOIN (SELECT id, programmer AS friend FROM programmers WHERE id IN (SELECT friend_id FROM programmers WHERE friend_id IS NOT NULL)) AS FriendsList
ON friend_id = FriendsList.id
;

4. Name of all programmers that no one has as a friend.

SELECT programmer AS lonely FROM programmers
WHERE id NOT IN (SELECT friend_id FROM programmers WHERE friend_id IS NOT NULL)
;

5. Name the programmers and their technology who has more than 7 years of experience.
Group them by the technology in alphabetical order.

SELECT programmer, technology FROM programmers
LEFT JOIN programmers_technologies
ON id = programmers_technologies.programmer_id
LEFT JOIN technologies
ON technologies.id = programmers_technologies.technology_id
WHERE experience > 7
ORDER BY technology ASC
;
6. For each technology we would like a comma-separated list of programmers.

SELECT technology, string_agg(programmer, ', ') FROM technologies
LEFT JOIN programmers_technologies
ON id = programmers_technologies.technology_id
LEFT JOIN programmers
ON programmers.id = programmers_technologies.programmer_id
GROUP BY technology;

7. Do you have any suggestions about what to change so that it can be more flexible or
extensible in the future?
In this case I think it would probably be easier to have just two tables: programmers (add technology_id as foreign key) and technologies.

RAILS
The following questions utilize the same tables:

1. Write a set of basic Rails models that fit the tables above and incorporate any
identifiable relationships.
class Programmer < ActiveRecord::Base
  has_many :programmers_technologies
  has_many :technologies, through: :programmers_technologies

  validates :programmer, presence: true
  validates :experience, presence: true, numericality: { only_integer: true }
  validates :is_senior, presence: true
  validates :friend_id, numericality: { only_integer: true }
end

class Technology < ActiveRecord::Base
  has_many :programmers_technologies
  has_many :programmers, through: :programmers_technologies
  validates :technology, presence: true
end

class ProgrammerTechnology < ActiveRecord::Base
  belongs_to :programmer
  belongs_to :technology
end

2. For the following, write a Rails ActiveRecord Query that generates the answer (using the

models you wrote in question 1):

1. A collection of all programmers whose technology starts with a “p” or contains an “e”

technologies = Technology.where("technology LIKE (?) OR technology LIKE (?)", "#{"p"}%", "%#{"e"}%")

programmers = []
technologies.each do |tech|
  tech.programmers.each do |prog|
     programmers << prog.programmer
  end
end


2. A collection of programmers who have no friends.
programmers = Programmer.where('friend_id IS NULL')
programers.each do |a|
  a.programmer
end

3. A collection of programmers who have more than 7 years of experience,
grouped by technology, sorted alphabetically ascending by technology.
programmers = Programmer
  .where('experience > ?', 7)
  .joins(:technologies)
  .group("programmers.id, technologies.technology")
  .order("technologies.technology ASC")
