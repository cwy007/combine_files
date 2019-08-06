require "json"

# 合并文件
tests = []
Dir["source/**/**.side"].each do |file_path|
  test_case = JSON.parse(File.read(file_path))
  tests << test_case["tests"]
end

udesk_atar = JSON.parse(File.read("udesk_atar.side"))
udesk_atar["tests"] = tests.flatten.uniq

File.open("udesk_atar.side", "w") { |f| f.write udesk_atar.to_json }

puts `cat udesk_atar.side`.split(",")

# 拆分文件
udesk_atar = JSON.parse(File.read("udesk_atar.side"))
puts udesk_atar["tests"].count

udesk_atar["tests"].each do |test|
  file_path = "source/#{test["name"]}.side"
  next if File.file?(file_path)
  test_case = udesk_atar
  test_case["tests"] = [test]

  File.open("#{file_path}", "w") { |f| f.write test_case.to_json }
end