# 合并 json 数据

从多个文件中获取特定的数据，合并到一个文件中

```ruby
require "json"

tests = []
Dir["source/**/**.side"].each do |file_path|
  test_case = JSON.parse(File.read(file_path))
  tests << test_case["tests"]
end

udesk_atar = JSON.parse(File.read("udesk_atar.side"))
udesk_atar["tests"] = tests.flatten.uniq

File.open("udesk_atar.side", "w") { |f| f.write udesk_atar.to_json }

puts `cat udesk_atar.side`.split(",")

```

## 问题出处

合并由多个人使用 selenium ide 录制的的测试用例

## 命令行脚本

```bash
where ruby
```

```ruby
#!/usr/bin/env ruby

require "json"

tests = []
Dir["source/**/**.side"].each do |file_path|
  test_case = JSON.parse(File.read(file_path))
  tests << test_case["tests"]
end

udesk_atar = JSON.parse(File.read("udesk_atar.side"))
udesk_atar["tests"] = tests.flatten.uniq

File.open("udesk_atar.side", "w") { |f| f.write udesk_atar.to_json }
```

```bash
chmod +x udesk_atar
```

<https://cobwwweb.com/add-console-to-ruby-project>

<https://cobwwweb.com/command-line-scripts-using-ruby>