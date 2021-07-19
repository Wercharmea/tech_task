class Store
  def initialize
    @store = {}
  end

  def save(key, value)
    @store[key] = value
  end

  def fetch(key)
    @store[key]
  end
end
