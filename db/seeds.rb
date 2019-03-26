p 'Create categories'
  categories = CSV.read(File.join(Rails.root, "db", "data", "categories.csv"))
  categories.each do |data|
    name, ordering = data
    category = Category.where(name: name).first_or_initialize
    category.name = name
    category.ordering = ordering
    category.save!
  end
