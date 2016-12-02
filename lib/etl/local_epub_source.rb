class LocalEpubSource
  def initialize(folder)
    @folder = folder
  end

  def each
    Dir.glob("#{folder}/*.epub") do |file|
      yield file
    end
  end

  private

  attr_reader :folder
end
