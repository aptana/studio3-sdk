# for use locally to test pre-generating rubles in Users's ruble directory
main_dir = File.expand_path(File.dirname(__FILE__))
$: << main_dir
main = File.join(main_dir, 'main.rb')

# We loop through the rubles found in user's directory, generating cache files for each
Dir.chdir(File.expand_path('~/Documents/Aptana Rubles')) do
  Dir.glob('*.ruble') do |ruble_dir|
    full_path = File.join(Dir.pwd, ruble_dir)
    puts "Generating cache file(s) for #{ruble_dir}"
    puts `ruby -KU "#{main}" "#{full_path}"`
  end
end
