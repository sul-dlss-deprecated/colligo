require 'rails_helper'

describe 'Homepage browse by century facet', type: :feature, js: true do
  it 'should have a slider and graph' do
    visit('/')
    # It should have the graph
    expect(page).to have_css('canvas.flot-base', count: 1)
    expect(page).to have_css('canvas.flot-overlay', count: 1)
    # It should have the slider
    expect(page).to have_css('div.slider-track', count: 1)
    expect(page).to have_css('div.min-slider-handle', count: 1)
    expect(page).to have_css('div.max-slider-handle', count: 1)
  end
  # TODO: I am not able to extract any of the values to test that it's working
  # it 'should set values on slide' do
  #   visit('/')
  #   find('div.min-slider-handle').drag_by(0, 50)
  #   sleep 2
  #   # puts '----------------------'
  #   # save_and_open_page
  #   # puts find_field('range_pub_date_t_begin').value
  #   # puts find_field('range_pub_date_t_end').value
  #   # puts page.evaluate_script('document.getElementById("range_pub_date_t_begin").value')
  #   # puts page.evaluate_script("$('form.range_limit input#range_pub_date_t_begin').val")
  #   # puts page.evaluate_script("$('div.max-slider-handle').attr('aria-valuenow')").inspect
  #   # puts '----------------------'
  # end
end
