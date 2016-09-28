class CategoryController < ApplicationController
  before_action :authenticate_user!, except: [:new, :create]
  
  def update_current
    current_user.categorys_users_relations.where(category_id: params[:catergory_id]).update_all(value: params[:value])
    cat = CategorysUsersRelation.joins(:category).where(categories: {parent_id: params[:parent_id]}, user: current_user)
    data = { id: params[:parent_id], average: cat.average(:value).to_i }
    render json: { success: true, data: data,status: 200 }
  end

  def update_desire
    current_user.categorys_users_relations.where(category_id: params[:catergory_id]).update_all(desire_value: params[:value])
    render json: { success: true, status: 200 }
  end

  def create_category_user_relation
    category_user_relation = current_user.categorys_users_relations.where(category_id: params[:catergory_id]).first_or_create!
    render json: { success: true, id: category_user_relation, status: 200 }
  end

  def delete_category_user_relation
    CategorysUsersRelation.where(user: current_user, category_id: params[:catergory_id]).destroy_all
    render json: { success: true, status: 200 }
  end

  def relation
    category = CategorysUsersRelation.joins(:category).where(categories: {parent_id: params['catergory_id']}, user: params['user'])
    array = Array.new
    i = 0
    for cat in category
      hash = { id: cat.category_id, value: cat.value, desire_value: cat.desire_value, name: cat.category.name } 
      array[i] = hash
      i += 1
    end
    render json: { success: true, status: 200, data: array }
  end

  def relation_one
    cat = CategorysUsersRelation.where(category_id: params['category_id'], user_id: params['user']).first
    hash = { id: params['category_id'], value: cat.value, desire_value: cat.desire_value, name: cat.category.name } 
    render json: { success: true, status: 200, data: hash }
  end
end
