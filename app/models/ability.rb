# frozen_string_literal: true

class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    if user.super_admin?
      can :manage, :all
    elsif user.admin?
      can :manage, [Booking, Field, FieldType]
    elsif user.user?
      can :read, [Field, FieldType]
      can :read, FavoriteFieldType, user_id: user.id
      can :update, User, id: user.id
      can %i[create destroy read], Booking , user_id: user.id
      can :create, FavoriteFieldType
      can :create, Review
      can :create, Comment
    else
      can :read, [Field, FieldType]
    end
  end
end
