class Spree::Calculator::QuebecTax < Spree::Calculator
  def self.description
    "Quebec Tax"
  end

  def self.register
    super
  end

  def compute_order(order)
    calculate_taxation(order.item_total)
  end

  def compute_line_item(line_item)
    calculate_taxation(line_item.amount)
  end

  private

  def calculate_taxation(total)
    tps = total * 0.05
    tvq = total * 0.09975 #TVQ
    tax = round_to_two_places(tps + tvq)
    return tax
  end

  def round_to_two_places(amount)
    BigDecimal.new(amount.to_s).round(2, BigDecimal::ROUND_HALF_UP)
  end
end
