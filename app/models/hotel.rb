## schema infomation
# table : hotel
#
# name: string
# address: string
# avatar: string
# star: integer
# rate_avg: float
# desciption: string

class Hotel < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, presence: true, length: {maximum: 20}
  validates :address, presence: true
  validates :description, presence: true
  validates :phone, presence: true
  validates :star, presence: true,
    numericality: {greater_than: 0, less_than_or_equal_to: 5}
  validates :max_price, presence: true
  validates :min_price, presence: true
  mount_uploader :avatar, HotelAvatarUploader

  ["rate_one", "rate_two", "rate_three", "rate_four", "rate_five"]
    .each do |rate|
      define_method rate do
        reviews.where(rate: Settings.rate.send(rate)).size
      end
    end

  def total_rate
    self.update_attributes(rate_count: (self.rate_one + self.rate_two + self.rate_three +
      self.rate_four + self.rate_five))
    self.rate_one + self.rate_two + self.rate_three +
      self.rate_four + self.rate_five
  end

  def avg_rate
    unless total_rate==0
      self.update_attributes(rate_sum: (((self.rate_one*1 + self.rate_two*2 + self.rate_three*3 +
        self.rate_four*4 + self.rate_five*5)*100/total_rate)/100.to_f))
      ((self.rate_one*1 + self.rate_two*2 + self.rate_three*3 +
        self.rate_four*4 + self.rate_five*5)*100/total_rate)/100.to_f
    else
      0
    end
  end

  #vi width cua bar-rate la 80% nen nhan vs 80
  def rate_one_per
    unless total_rate==0
      (self.rate_one/self.total_rate.to_f)*80.to_i
    else
      0
    end
  end

  def rate_two_per
    unless total_rate==0
      (self.rate_two/self.total_rate.to_f*80).to_i
    else
      0
    end
  end

  def rate_three_per
    unless total_rate==0
      (self.rate_three/self.total_rate.to_f*80).to_i
    else
      0
    end
  end

  def rate_four_per
    unless total_rate==0
      (self.rate_four/self.total_rate.to_f*80).to_i
    end
  end

  def rate_five_per
    unless total_rate==0
      (self.rate_five/self.total_rate.to_f*80).to_i
    end
  end

end
