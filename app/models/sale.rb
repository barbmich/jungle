class Sale < ActiveRecord::Base

  def finished?
    ends_on < Date.current
  end

  def upcoming?
    starts_on > Date.current
  end

  #not needed, just added for additional info:
  def active?
    !upcoming? && !finished?
  end

  #AR Scope
  def self.active
    self.where("sales.starts_on <= ? AND sales.ends_on >= ?", Date.current, Date.current)
  end

end
