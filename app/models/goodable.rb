module Goodable
  attr_accessor :goods_count

  def good?(_user)
    raise
  end

  def increment_counter
    @goods_count += 1
  end

  def decrement_counter
    @goods_count -= 1
  end
end
