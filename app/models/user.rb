# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :mobiles, dependent: :destroy

  validates :first_name, presence: true
  validates :last_name, presence: true

  # has_one_attached :avatar
  mount_uploader :avatar, AvatarUploader

  enum role: %i[user admin]
  after_initialize :set_default_role, if: :new_record?

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  def subscribed?
    subscriptions.where(status: 'active').any?
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
