module BBall
  
  def self.findNilSalaries
    nil_salaries = Membership.where(salary: [nil,0])
  end
end
