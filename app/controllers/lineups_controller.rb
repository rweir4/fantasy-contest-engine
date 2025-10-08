class LineupsController < ApplicationController
  before_action :set_lineup, only: %i[ show update destroy ]
  before_action :set_contest, only: [ :index, :create ]

  def index
    @lineups = @contest.lineups

    render json: @lineups
  end

  def show
    render json: @lineup
  end

  def create
    @lineup = @contest.lineups.build(lineup_params)

    if @lineup.save
      render json: @lineup, status: :created, location: @lineup
    else
      render json: { errors: @lineup.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if @lineup.update(lineup_params)
      render json: @lineup
    else
      render json: { errors: @lineup.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    @lineup.destroy!
  end

  private
    def set_lineup
      @lineup = Lineup.find(params.expect(:id))
    end

    def set_contest
      @contest = Contest.find(params.expect(:contest_id))
    end

    def lineup_params
      params.expect(lineup: [ :user_id, :total_score ])
    end
end
