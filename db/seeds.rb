# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Ripple.delete_all

Ripple.create!(name: 'QwertyMan', 
                url: 'www.jinglebells.com', 
                message: %{Have a holly jolly Christmas... ...it's the best time of the year.})

Ripple.create!(name: 'Dr. Claw',
                url: 'www.clawindustries.business',
                message: 'NEXT TIME GADGET!')

Ripple.create!(name: 'Anon E. Mouse',
                url: 'www.4chan.com',
                message: %{Can't touch this (duh duh duh duh, duh duh, duh duh)})
Ripple.create!(name: 'Donec',
                message: 'ullamcorper viverra. Maecenas iaculis aliquet diam. Sed 
                          diam dorem, auctor quinon.')
