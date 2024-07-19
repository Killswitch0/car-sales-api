class Api::V1::AdvertisementsController < ApplicationController
  before_action :set_advertisement, only: %i[ show update destroy destroy_photo like unlike ]

  # Scopes for filtering advertisements.
  has_scope :by_brand
  has_scope :by_model
  has_scope :by_body_type
  has_scope :by_mileage
  has_scope :by_colour
  has_scope :by_price, using: %i[start_price, end_price]
  has_scope :by_fuel
  has_scope :by_year, using: %i[start_year, end_year]
  has_scope :by_engine_capacity, using: %i[start_capacity, end_capacity]

  api :GET, '/v1/advertisements', 'Returns a list of advertisements.'
  param :my_advert, :boolean, desc: 'Returns a list of advertisements with optional filters applied.'
  #----------------------------------------------------------------------------
  def index
    @advertisements = apply_scopes(Advertisement).all
    @advertisements = current_user.advertisements if params[:my_advert].present?
    render json: AdvertisementSerializer.new(@advertisements, include: [:user]).serializable_hash.to_json
  end

  api :GET, '/v1/advertisements/favorites', 'Returns a list of advertisements marked as favorites by the current user.'
  #----------------------------------------------------------------------------
  def favorites
    @advertisements = Advertisement.joins(:likes).where('likes.user_id = ?', current_user)
    render json: AdvertisementSerializer.new(@advertisements, include: [:user]).serializable_hash.to_json
  end

  api :GET, '/v1/advertisements/:id', 'Returns specific advertisement.'
  param :id, :number, desc: 'ID of the advertisement', required: true
  #----------------------------------------------------------------------------
  def show 
    render json: AdvertisementSerializer.new(@advertisement, include: [:user]).serializable_hash.to_json
  end

  api :POST, '/v1/advertisements', 'Creates a new advertisement.'
  param :advertisement, Hash, desc: 'Advertisement attributes', required: true
  #----------------------------------------------------------------------------
  def create
    @advertisement = current_user.advertisements.build(advertisement_params)

    if @advertisement.save 
      render json: AdvertisementSerializer.new(@advertisement).serializable_hash.to_json,
        status: :created
    else
      render json: @advertisement.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :PATCH, '/v1/advertisements/:id', 'Updates an existing advertisement.'
  param :id, :number, desc: 'ID of the advertisement', required: true
  #----------------------------------------------------------------------------
  def update
    if @advertisement.update(advertisement_params)
      render json: AdvertisementSerializer.new(@advertisement).serializable_hash.to_json
    else
      render json: @advertisement.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :DELETE, '/v1/advertisements/:id', 'Deletes an advertisement.'
  param :id, :number, desc: 'ID of the advertisement', required: true
  #----------------------------------------------------------------------------
  def destroy
    @advertisement.destroy
    head :no_content
  end

  api :DELETE, '/v1/advertisements/:id/destroy_photo', 'Deletes the photo associated with an advertisement.'
  param :id, :number, desc: 'ID of the advertisement', required: true
  #----------------------------------------------------------------------------
  def destroy_photo
    @advertisement.photo.purge
    render json: { message: "Photo deleted successfully" }, status: :ok
  end

  api :GET, '/v1/advertisements/by_state', 'Fetches advertisements filtered by state.'
  param :state, String, desc: 'State of the advertisement', required: false
  #----------------------------------------------------------------------------
  def by_state
    @state = params[:state]

    if @state.present?
      @advertisements = Advertisement.where(state: @state)
    else
      @advertisements = Advertisement.all
    end

    render json: AdvertisementSerializer.new(@advertisements).serializable_hash.to_json
  end

  api :POST, '/v1/advertisements/:id/like', 'Likes an advertisement.'
  param :id, :number, desc: 'ID of the advertisement', required: true
  #----------------------------------------------------------------------------
  def like
    current_user.likes.create(likeable: @advertisement)
    head :no_content
  end

  api :DELETE, '/api/v1/advertisements/:id/unlike', 'Unlikes an advertisement.'
  param :id, :number, desc: 'ID of the advertisement', required: true
  #----------------------------------------------------------------------------
  def unlike
    current_user.likes.find_by(likeable: @advertisement).destroy
    head :no_content
  end

  private 

  def set_advertisement
    @advertisement = Advertisement.find(params[:id])
  end

  def advertisement_params
    params.require(:advertisement)
      .permit(
        :brand,
        :model,
        :body_type,
        :mileage,
        :colour,
        :price,
        :fuel,
        :year,
        :engine_capacity,
        :phone_number,
        :name,
        :photo,
        :state
      )
  end
end
