main_dir = File.expand_path(File.dirname(__FILE__))
$: << main_dir
main = File.join(main_dir, 'main.rb')

Dir.chdir('/Users/cwilliams/repos') do
  Dir.glob('*.ruble') do |ruble_dir|
    full_path = File.join(Dir.pwd, ruble_dir)
    `ruby -I#{main_dir} -KU #{main} #{full_path}`
  end
end
