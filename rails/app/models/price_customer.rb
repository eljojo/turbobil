class PriceCustomer < ActiveRecord::Base
    self.table_name = 'price_customer'

    validates :name, presence: true
    validates :percent_recharge, presence: true
    validates :admin_id, presence: true

    has_many :calls, :class_name => 'Call'
    has_many :rates_customers, :class_name => 'RatesCustomer'
    belongs_to :admin, :class_name => 'Admin', :foreign_key => :admin_id

  def final_price (route, final_price=nil)
    rc = RateCustomer.find_by(route: route, price_customer: id)
    if rc
      rc.value
    else
      final_price  + (final_price * percent_recharge) / 100
    end
  end

  def to_s
    name
  end

end
