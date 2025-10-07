class LineupsController < ApplicationController
  before_action :set_lineup, only: %i[ show update destroy ]

  # GET /lineups
  def index
    @lineups = Lineup.all

    render json: @lineups
  end

  # GET /lineups/1
  def show
    render json: @lineup
  end

  # POST /lineups
  def create
    @lineup = Lineup.new(lineup_params)

    if @lineup.save
      render json: @lineup, status: :created, location: @lineup
    else
      render json: @lineup.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /lineups/1
  def update
    if @lineup.update(lineup_params)
      render json: @lineup
    else
      render json: @lineup.errors, status: :unprocessable_content
    end
  end

  # DELETE /lineups/1
  def destroy
    @lineup.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lineup
      @lineup = Lineup.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def lineup_params
      params.expect(lineup: [ :user_id, :contest_id, :total_score ])
    end
end
