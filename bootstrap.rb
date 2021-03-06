puts "bootstrapping your workspace for EE160 (this might take awhile)..."

puts "setting up your directories (i.e. folders)"
  `git clone https://github.com/zhaol/ee160_scaffold.git ee160`

puts "installing dependencies..."
  `gem install bundler -v 1.6.2`

puts "setting up your scripts"
Dir.chdir do
  `git clone https://github.com/zhaol/ee160_scripts.git`
  `cd ee160_scripts && bundle`
end

puts "your workspace is now bootstrapped...have a wonderful semester"
