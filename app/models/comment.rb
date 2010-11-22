class Comment < ActiveRecord::Base

  include ActsAsCommentable::Comment

  belongs_to :commentable, :polymorphic => true

  default_scope :order => 'created_at ASC'

  # NOTE: install the acts_as_votable plugin if you
  # want user to vote on the quality of comments.
  #acts_as_voteable

  # NOTE: Comments belong to a user
  belongs_to :user
validates_length_of :comment, :within => 10..600, :on => :create, :too_long => I18n.t("activerecord.errors.messages.comment.too_long_content"),:too_short => I18n.t("activerecord.errors.messages.comment.too_short_content")
end
