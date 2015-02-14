class Api::OngoingMatchesController < ApplicationController
  before_action :ongoing_match

  def show
    unless ongoing_match
      head :not_found
    end
  end

  def home_point
    if record_service ongoing_match.home_player
      render :show
    else
      render :show, status: :unprocessable_entity
    end
  end

  def away_point
    if record_service ongoing_match.away_player
      render :show
    else
      render :show, status: :unprocessable_entity
    end
  end

  def rewind
    if rewind_match
      render :show
    else
      render :show, status: :unprocessable_entity
    end
  end

  def finalize
    ongoing_match.finalize!
    render :show
  end

  private

  def record_service victor
    PingPong::Service.new(
      match: ongoing_match,
      victor: victor
    ).record!
  end

  def rewind_match
    PingPong::Rewind.new(ongoing_match).rewind!
  end

  def ongoing_match
    @match ||= Match.ongoing.first
  end
end