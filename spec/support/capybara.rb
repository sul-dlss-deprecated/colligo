# Ref: https://codedecoder.wordpress.com/2015/10/05/jquery-slider-drag-drop-rspec-capybara/
# http://stackoverflow.com/questions/10866960/how-do-i-drag-a-jquery-slider-handle-from-within-capybara-and-chromedriver
module CapybaraExtension
  def drag_by(right_by, down_by)
    base.drag_by(right_by, down_by)
  end
end

module CapybaraSeleniumExtension
  def drag_by(right_by, down_by)
    driver.browser.action.drag_and_drop_by(native, right_by, down_by).perform
  end
end

::Capybara::Selenium::Node.send :include, CapybaraSeleniumExtension
::Capybara::Node::Element.send :include, CapybaraExtension
