class RubyWeeklyController

  def initialize
    puts "Welcome to RubyWeekly!!!"

    s = RubyWeeklyScraper.new(286)
    @newsletter = s.scrape
  end

  def call
    input = ""
    while input != "exit"
      puts "What would you like to do?"
      input = gets.strip
      case input
      when "list"
        list_articles
      when "exit"
        puts "Goodbye"
        break
      else
        system("open #{@newsletter.articles[input.to_i-1].url}")
      end
    end
  end

  def list_articles
    @newsletter.articles.each.with_index(1) do |a, i|
      puts "#{i}. #{a.title}"
    end
  end
end
