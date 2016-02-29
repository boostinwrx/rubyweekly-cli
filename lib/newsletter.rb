class InvalidType < StandardError; end

class Newsletter
  attr_accessor :issue_number, :issue_date
  # attr_reader :articles

  def initialize
    @articles = []
  end

  def articles
    @articles.dup.freeze
  end

  def add_article(article)
    if !article.is_a?(Article)
      raise InvalidType, "must be an Article"
    else
      @articles << article
    end
  end

end
