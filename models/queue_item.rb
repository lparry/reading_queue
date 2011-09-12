class QueueItem < ActiveRecord::Base
  scope :unread, :conditions => {:read => false}
  default_scope :order => 'id ASC'
end
