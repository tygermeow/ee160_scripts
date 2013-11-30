!# /usr/bin/env ruby

puts "bootstrapping your workspace for EE160 (this might take awhile)..."

puts "setting up your directories (i.e. folders)"
  `git clone https://github.com/zhaol/ee160_scaffold.git`

puts "installing dependencies..."
  `gem install twitter -v 5.0.0.rc.1`
  `gem install wavefile`

puts "setting up your scripts"
Dir.chdir do
  `git clone https://github.com/zhaol/ee160_scripts.git`
end

puts "your workspace is now bootstrapped...have a wonderful semester"