class Address < ApplicationRecord
  belongs_to :customer

  def address_display
  '〒' + self.post_number + ' ' + self.address + ' ' + self.name
  end

end
