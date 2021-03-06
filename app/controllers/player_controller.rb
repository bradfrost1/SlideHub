class PlayerController < ApplicationController
  include SlideUtil
  before_action :set_slide

  def show
    # increment only when the player is embedded in other site...
    unless params.key?(:inside) && params[:inside] == '1'
      @slide.increment(:embedded_view).increment(:total_view).save
    end
    @start_position = slide_position
    s = render_to_string layout: 'javascript', collection: @slide
    render text: s, layout: false, content_type: 'application/javascript'
  end

  private

    def slide_position
      position = 1
      position = params[:page].to_i if params.key?(:page) && params[:page].to_i > 0
      position
    end
end
