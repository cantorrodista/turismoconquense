class Comment < ActiveRecord::Base
  include Drafteable
  
  belongs_to :commentable, :polymorphic => true

  validates_presence_of :message
  validates_presence_of :IP
  validates_presence_of :email
  validates_presence_of :name
  
  attr_protected :checked
  
  
  def before_create
    self.published = true if Settings.comments.activate_moderation != 1
    return true
  end


  def self.check_comments!(ids)
    checked_comments = Comment.find(:all, :conditions => ["comments.id IN (?)", ids])
    if checked_comments.size > 0
      checked_comments.each do |checked_comment|
        checked_comment.update_attribute(:checked, true)
      end
    else
      return nil
    end
  end

  def author_avatar
      '/images/avatars/missing_medium.png'
  end
  
  def author_name
      self.name
  end
  
  def author_email
    self.email 
  end
  
  def self.drafts_without_checked(order_by = 'name ASC')
    find(:all, :order => order_by, :conditions => ['published = ?', false])
  end
  
  def self.published_without_checked(order_by = 'created_at ASC')
    find(:all, :order => order_by, :conditions => ['published = ?', true])
  end
  
  private
    def without_author?
      self.author.nil?
    end
end
