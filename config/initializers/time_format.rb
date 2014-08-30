Time.class_eval do
  def my_format
    self.strftime("%d %b %I:%M%P")
  end
end
