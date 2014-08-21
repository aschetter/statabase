module BBall
  
  def self.parseSalaries(htmlPage)

    @player_salaries = []

    salaries = htmlPage[:salaries]

    salaries.each do |player|

      a_tag = salary_info[1].css('a')

      if a_tag 

        salary_info = player.css('td')
        href = salary_info[1].css('a').attr("href").value

        player_salary = {
          br_id: href.slice(11..(href.index('.')-1)),
          name: salary_info[1].css('a').text,
          salary: salary_info[2].attr("csk").to_i
        }

      end

      @player_salaries << player_salary
    end

    @player_salaries
  end
end
