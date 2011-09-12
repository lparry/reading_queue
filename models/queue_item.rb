class QueueItem < ActiveRecord::Base
  scope :unread, :conditions => {:read => false}
end
