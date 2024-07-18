class Api::V1::AdvertisementsController < ApplicationController
  before_action :set_advertisement, only: %i[ show update destroy destroy_photo like unlike ]

  # GET /api/v1/advertisements
  #----------------------------------------------------------------------------
  def index
    @advertisements = Advertisement.all
    @advertisements = current_user.advertisements if params[:my_advert].present?
    render json: AdvertisementSerializer.new(@advertisements).serializable_hash.to_json
  end

  # GET /api/v1/advertisements/favorites
  #----------------------------------------------------------------------------
  def favorites
    @advertisements = Advertisement.joins(:likes).where('likes.user_id = ?', current_user)
    render json: AdvertisementSerializer.new(@advertisements).serializable_hash.to_json
  end

  # GET /api/v1/advertisements/:id
  #----------------------------------------------------------------------------
  def show 
    render json: AdvertisementSerializer.new(@advertisement).serializable_hash.to_json
  end

  # POST /api/v1/advertisements
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

  # PATCH/PUT /api/v1/advertisements/:id
  #----------------------------------------------------------------------------
  def update
    if @advertisement.update(advertisement_params)
      render json: AdvertisementSerializer.new(@advertisement).serializable_hash.to_json
    else
      render json: @advertisement.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/advertisements/:id
  #----------------------------------------------------------------------------
  def destroy
    @advertisement.destroy
    head :no_content
  end

  # DELETE /api/v1/advertisements/:id/destroy_photo
  #----------------------------------------------------------------------------
  def destroy_photo
    @advertisement.photo.purge
    render json: { message: "Photo deleted successfully" }, status: :ok
  end

  # GET /api/v1/advertisements/by_state?state=:state
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

  # POST /api/v1/advertisements/:id/like
  #----------------------------------------------------------------------------
  def like
    current_user.likes.create(likeable: @advertisement)
    head :no_content
  end

  # DELETE /api/v1/advertisements/:id/unlike
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
