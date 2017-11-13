module WebkitHelper
  def confirm_dialog
    page.evaluate_script('window.confirm = function() { return true; }')
  end
end
