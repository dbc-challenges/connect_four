class TwitterPlayer
  def initialize(options={})
    @piece = options[:piece]
  end

  def move
    rand(7)
  end
end