say "\nInstalling Kaminari paginator\n", Thor::Shell::Color::YELLOW

gem 'kaminari'

generate_views = yes?('Generate Kaminari views? [y|n]: ', Thor::Shell::Color::BLUE)
if generate_views
  theme = 'default'
  templater.post_bundler do
    options = [theme]
    options << "-e haml" if templater.template_engine.haml? || templater.template_engine.slim?
    generate 'kaminari:views', *options

    if templater.template_engine.slim?
      haml_files = Dir.glob File.join("app", "views", "kaminari", "*.haml")
      haml_files.each do |haml_file|
        slim_file = haml_file.sub /haml$/, 'slim'
        system "bundle exec haml2slim #{haml_file} #{slim_file}"
        remove_file haml_file
      end
    end
  end
end
