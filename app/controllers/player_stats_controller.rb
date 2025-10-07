class PlayerStatsController < ApplicationController
  before_action :set_player_stat, only: %i[ show update destroy ]

  # GET /player_stats
  def index
    @player_stats = PlayerStat.all

    render json: @player_stats
  end

  # GET /player_stats/1
  def show
    render json: @player_stat
  end

  # POST /player_stats
  def create
    @player_stat = PlayerStat.new(player_stat_params)

    if @player_stat.save
      render json: @player_stat, status: :created, location: @player_stat
    else
      render json: @player_stat.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /player_stats/1
  def update
    if @player_stat.update(player_stat_params)
      render json: @player_stat
    else
      render json: @player_stat.errors, status: :unprocessable_content
    end
  end

  # DELETE /player_stats/1
  def destroy
    @player_stat.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_stat
      @player_stat = PlayerStat.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def player_stat_params
      params.expect(player_stat: [ :player_id, :game_week, :stats, :fantasy_points ])
    end
end
