def findNilSalaries
  nil_salaries = Membership.where(salary: nil)
end
