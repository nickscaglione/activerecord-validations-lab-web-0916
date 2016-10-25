class Post < ActiveRecord::Base
  TOP_NO = (1..9).map { |i| "Top #{i}" }
  CLICKBAIT = ["Won't Believe", "Secret"] + TOP_NO

  validates :content, length: {minimum: 250}
  validates :summary, length: {maximum: 250}
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
  validate :clickbaity?
  validates :title, presence: true

  def clickbaity?
    if self.title
      bait_bool = CLICKBAIT.any? do |phrase|
        self.title.include?(phrase)
      end
      if bait_bool
        return true
      else
        self.errors[:name] << 'Title needs more clickbait'
        return false
      end
    else
      false
    end
  end

end
