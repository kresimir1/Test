
# 3. Write a method in Ruby that, given any 2 strings, will return true if the first string is
# contained in the second one, and false otherwise.

def str_includes(str1, str2)
  if str2.downcase.include?(str1.downcase)
    true
  else
    false
  end
end
