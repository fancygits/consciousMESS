require 'csv'

Ripple.delete_all

Ripple.create!(name: 'QwertyMan', 
                url: 'www.jinglebells.com', 
                message: %{Have a holly jolly Christmas... ...it's the best time of the year.})

Ripple.create!(name: 'Dr. Claw',
                url: 'www.clawindustries.business',
                message: 'NEXT TIME GADGET!')

Ripple.create!(name: 'Anon E. Mouse',
                url: '',
                message: %{Can't touch this (duh duh duh duh, duh duh, duh duh)})

CSV.foreach(Rails.root.join('lib/seeds.csv'), headers: true) do |row|
  Ripple.create! row.to_hash
end
