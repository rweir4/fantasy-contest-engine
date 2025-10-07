class LineupPlayersController < ApplicationController
  before_action :set_lineup_player, only: %i[ show update destroy ]

  # GET /lineup_players
  def index
    @lineup_players = LineupPlayer.all

    render json: @lineup_players
  end

  # GET /lineup_players/1
  def show
    render json: @lineup_player
  end

  # POST /lineup_players
  def create
    @lineup_player = LineupPlayer.new(lineup_player_params)

    if @lineup_player.save
      render json: @lineup_player, status: :created, location: @lineup_player
    else
      render json: @lineup_player.errors, status: :unprocessable_content
    end
  end

  # PATCH/PUT /lineup_players/1
  def update
    if @lineup_player.update(lineup_player_params)
      render json: @lineup_player
    else
      render json: @lineup_player.errors, status: :unprocessable_content
    end
  end

  # DELETE /lineup_players/1
  def destroy
    @lineup_player.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lineup_player
      @lineup_player = LineupPlayer.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def lineup_player_params
      params.expect(lineup_player: [ :lineup_id, :player_id, :position_slot ])
    end
end
