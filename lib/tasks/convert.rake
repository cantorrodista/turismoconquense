namespace :highlights do
  desc "lee cuerpos de noticias"
  task :update => :environment do
     Newsparser.load_voces
     Newsparser.load_cuencainformacion
     Newsparser.load_cerca
  end
end
