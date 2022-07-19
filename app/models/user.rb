# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :recipient, dependent: :destroy

  # has_one_attached :avatar
  mount_uploader :avatar, AvatarUploader

  enum role: %i[user admin]
  after_initialize :set_default_role, if: :new_record?

  def full_name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end

  private

  def set_default_role
    self.role ||= :user
  end
end
