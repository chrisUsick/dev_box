
file "#{ENV['HOME']}/test.txt" do
  content 'This file was created by Chef!'
end

include_recipe 'chrome::default'

