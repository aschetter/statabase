def adjustPlayerSalaries(percentages)

  percentages.each do |percentage|
    percentage.each do |membership|

      total_salary = membership[:total_salary]
      gp_percentage = membership[:gp_percentage]

      db_membership = Membership.find(membership[:membership_id])

      db_membership.salary = total_salary * gp_percentage

      db_membership.salary
      db_membership.save
    end
  end
end
