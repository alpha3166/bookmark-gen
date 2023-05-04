require "./parser.rb"
require "erb"

SRC = FileList["txt/*.txt"]
DEST = SRC.pathmap("%{txt,html}X.html")

task :default => DEST

rule ".html" => ["%{html,txt}X.txt", "layout.rhtml"] do |t|
  puts "#{t.source} -> #{t.name}"

  bookmark = parse(t.source)
  html = ERB.new(File.read("layout.rhtml"), trim_mode: "%").result(binding)

  dest_dir = File.dirname(t.name)
  mkdir_p dest_dir unless Dir.exist?(dest_dir)
  File.open(t.name, "w") do |f|
    f.write(html)
  end
end
