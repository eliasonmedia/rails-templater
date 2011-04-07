say "\nWhich ORM/ODM would you like to use?\n", Thor::Shell::Color::BLUE

orm_options = {
  'Option' => 'ORM/ODM',
  '1' => 'Mongoid',
  '2' => 'ActiveRecord'
}

print_table orm_options.to_a, :ident => 4

orm_selection = ask("\nOption: ", Thor::Shell::Color::BLUE)
if orm_selection.present?
  templater.orm.type = orm_options[orm_selection].underscore.to_sym
end

$stdout << "\n\n"

apply templater.recipe('mongoid') if templater.orm.mongoid?
apply templater.recipe('active_record') if templater.orm.active_record?

include_kaminari = yes?('[Models] Include kaminari paginator? [y|n]: ', Thor::Shell::Color::BLUE)
apply templater.recipe('kaminari') if include_kaminari
