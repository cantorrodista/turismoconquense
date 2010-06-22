require 'nokogiri'
require 'open-uri'
module Newsparser

  def self.load_voces
    Highlight.voces.scoped_by_with_body(false).each do |highlight|
      begin
        if doc = Nokogiri::HTML(open(highlight.source_url))
            body = ""
            doc.css('div#ppalnoticias p').each do |p|
              body << p.text
              body << '<br/>'
            end
            unless body.blank?
              highlight.excerpt = highlight.body
              highlight.summary = highlight.body
              highlight.body = body
              highlight.with_body = true
              highlight.save
            end
            # 
            # if !doc.css('div.contentdiv img').blank? && highlight.assets.blank?
            #     relative_path = doc.css('div.contentdiv img').attr('src').text
            #     path = "http://www.vocesdecuenca.com/frontend/voces/#{relative_path}"
            #     require 'ruby-debug'
            #     debugger
            #     remote_file = RemoteFile.new(path)
            #     highlight.assets.create(:data => remote_file)
            #     "Capturada imagen para #{highlight.name}"
            # end
            puts "Actualizada noticia: #{highlight.name}"
        end
        
      rescue  OpenURI::HTTPError
          puts "Error al leer noticia: #{e}"
      end
      
    end
  end
  
  
  
  def self.load_cuencainformacion
    Highlight.cuencainformacion.scoped_by_with_body(false).each do |highlight|
      begin
        if doc = Nokogiri::HTML(open(highlight.source_url))
            body = ""
            doc.css('td.vernoticia p').each do |p|
              body << p.text
              body << '<br/>'
            end
            unless body.blank?
              highlight.excerpt = highlight.body
              highlight.summary = highlight.body
              highlight.body = body
              highlight.with_body = true
              highlight.save
            end
            
            if !doc.css('td.vernoticia img').blank? && highlight.assets.blank?
                relative_path = doc.css('td.vernoticia img').attr('src').text
                path = "http://www.cuencainformacion.com/#{relative_path}"
                remote_file = RemoteFile.new(path)
                highlight.assets.create(:data => remote_file)
                puts "Capturada imagen para #{highlight.name}"
            end
            puts "Actualizada noticia: #{highlight.name}"
        end
        
      rescue  OpenURI::HTTPError
          puts "Error al leer noticia: #{e}"
      end
      
    end
  end
  
  
  def self.load_cerca
    Highlight.cerca.scoped_by_with_body(false).each do |highlight|
      begin
        if doc = Nokogiri::HTML(open(highlight.source_url))
            body = ""
            doc.css('div.cuerpo_noticia div').each do |p|
              body << p.text
              body << '<br/>'
            end
            unless body.blank?
              highlight.excerpt = highlight.body
              highlight.summary = highlight.body
              highlight.body = body
              highlight.with_body = true
              highlight.save
            end

            if !doc.css('div.article-image img').blank? && highlight.assets.blank?
                relative_path = doc.css('div.article-image img').attr('src').text
                remote_file = RemoteFile.new(relative_path)
                highlight.assets.create(:data => remote_file)
                puts "Capturada imagen para #{highlight.name}"
            end
            puts "Actualizada noticia: #{highlight.name}"
        end
        
      rescue  OpenURI::HTTPError
          puts "Error al leer noticia: #{e}"
      end
      
    end
  end
  
  
  

end

