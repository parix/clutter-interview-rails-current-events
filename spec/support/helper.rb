module Helper
  def file_fixture(path)
    File.open("spec/fixtures/files/#{path}", "r:UTF-8")
  end
end
