require 'active_support/all'

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
        @@tabs.sort # it sorts the elements in the @@tabs
      end
  end
end
