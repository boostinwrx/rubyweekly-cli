class RubyWeeklyScraper
  attr_accessor :newsletter, :doc

  def initialize(issue_number)
    @newsletter = Newsletter.new
    @newsletter.issue_number = issue_number
    @doc = Nokogiri::HTML(open("http://rubyweekly.com/issues/#{issue_number}"))
  end

  def scrape
    scrape_details
    scrape_articles
    @newsletter #=> This instance should have a bunch of articles and details
  end

  def scrape_details
    # populate @newsletter with more data from the newsletter site
    @newsletter.issue_date = @doc.search("table.gowide.lonmo").text.strip.gsub("Issue #{@issue_number} — ", "").strip
  end

  def scrape_articles
    # I would break the convention of only knowing about the Newsletter and let it create articles
    @doc.search("td[align='left'] table.gowide")[2..-1].each do |article_table|
      # instantiate the article
      a = Article.new
      a.author = article_table.search("div:first").text.strip
      a.title = article_table.search("a:first").text.strip
      a.url = article_table.search("a:first").attr("href").text.strip

      @newsletter.add_article(a)
      # scrape the data
      # add the article to the newsletter
    end
  end
end
