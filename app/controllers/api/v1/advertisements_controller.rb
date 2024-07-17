class Api::V1::AdvertisementsController < ApplicationController
  before_action :set_advertisement, only: %i[ show update destroy ]

  # GET /api/v1/advertisements
  def index
    @advertisements = Advertisement.all
    render json: AdvertisementSerializer.new(@advertisements).serializable_hash.to_json
  end

  # GET /api/v1/advertisements/:id
  def show 
    render json: AdvertisementSerializer.new(@advertisement).serializable_hash.to_json
  end

  # POST /api/v1/advertisements
  def create
    @advertisement = Advertisement.new(advertisement_params)

    if @advertisement.save 
      render json: AdvertisementSerializer.new(@advertisement).serializable_hash.to_json,
        status: :created
    else
      render json: @advertisement.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/advertisements/:id
  def update
    if @advertisement.update(advertisement_params)
      render json: AdvertisementSerializer.new(@advertisement).serializable_hash.to_json
    else
      render json: @advertisement.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/advertisements/:id
  def destroy
    @advertisement.destroy
    head :no_content
  end

  # GET /api/v1/advertisements/by_state?state=:state
  def by_state
    @state = params[:state]

    if @state.present?
      @advertisements = Advertisement.where(state: @state)
    else
      @advertisements = Advertisement.all
    end

    render json: AdvertisementSerializer.new(@advertisements).serializable_hash.to_json
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
        :user_id,
        :state
      )
  end
end
