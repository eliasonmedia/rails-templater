gem 'sqlite3-ruby', :require => 'sqlite3'

gsub_file 'config/application.rb', '# require "active_record/railtie"', 'require "active_record/railtie"'
create_file 'config/database.yml', templater.load_template('config/database.yml', 'active_record')
run 'cp config/database.yml config/database.yml.example'

include_meta_where = yes?('[ActiveRecord] Include MetaWhere ActiveRecord 3 query syntax extension? [y|n]: ', Thor::Shell::Color::BLUE)
apply templater.recipe('meta_where') if include_meta_where
