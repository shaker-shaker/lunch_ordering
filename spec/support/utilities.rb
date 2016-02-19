module Utilities
  def first_day_in_month(day_of_week)
    weekday = Date.new(Date.today.year, Date.today.month, 1)
    weekday += 1 while weekday.wday != day_of_week
    return weekday
  end

  def wait_for_ajax
    return unless respond_to?(:evaluate_script)
    wait_until { finished_all_ajax_requests? }
  end

  def finished_all_ajax_requests?
    evaluate_script("!window.jQuery") || evaluate_script("jQuery.active").zero?
  end

  def wait_until(max_execution_time_in_seconds = Capybara.default_max_wait_time)
    Timeout.timeout(max_execution_time_in_seconds) do
      loop do
        if yield
          return true
        else
          sleep(0.05)
          next
        end
      end
    end
  end

  def sign_in(user)
    post_via_redirect user_session_path, 'user[email]' => user.email,
                                         'user[password]' => user.password
  end

  def select_date(date)
    page.find('#day-selector').click 
    within('.datepicker .datepicker-days') do
      all(:xpath, "//table//tr//td[text()='#{date.day}' \
                  and contains(@class, 'day') \
                  and not(contains(@class, 'disabled'))]")
      .last.click
      wait_for_ajax
    end
  end
end