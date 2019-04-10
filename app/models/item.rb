# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                  :bigint(8)        not null, primary key
#  original_price      :float            not null
#  has_discount        :boolean          default(FALSE)
#  discount_percentage :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Item < ApplicationRecord
  def price
    if has_discount == true
      original_price.to_f * (1 - (discount_percentage.to_f / 100)).round(2)
    else
      original_price
    end
  end

  def self.average_price
    list = []

    all.select { |elem| list << elem.price }
    list.sum / list.length
  end
end
