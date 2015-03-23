require 'open-uri'
require 'nokogiri'

ymlfile='data.yml'

namespace :pokemon do
  # descの記述は必須
  desc "ポケモンのデータを攻略サイトからパースしてきます"
  task :crawl => :environment do
    puts "dont exec"
    return

    uri_format = "http://www.pokemon-br.com/book/%d.html"
    uris = [*1..649].map{|i| uri_format%(i)}

    data =  uris.map do |uri|
      html = URI.parse(uri).read
      charset = html.charset
      if charset == "iso-8859-1"
        charset = html.scan(/charset="?([^\s"]*)/i).first.join
      end
      doc = Nokogiri::HTML.parse(html, nil, charset)

      params = {
        name: doc.xpath('//*[@class="pokename"]').first.text,
        kind: doc.xpath('//*[@class="bunrui"]').first.text.gsub(/(\(|（).+(\)|）)$/, ''),
        no: doc.xpath('//*[@class="num"]').first.text.match(/\d{3}/).to_s.to_i,
        type1: doc.xpath('//*[starts-with(@class, "zoku")]')[0].text,
        type2: doc.xpath('//*[starts-with(@class, "zoku")]')[1].try(:text),
      }

      evolution_list = doc.xpath('//*[@class="sinka"]').map{|i|
        i.text.chomp.gsub(/(\(|（).+(\)|）)$/, '').chomp
      }
      STDERR.puts evolution_list.inspect

      evolution_index = evolution_list.index(params[:name])
      if evolution_index && evolution_index > 0
        params[:evolution_from_name] = evolution_list[evolution_index - 1]
      end
      STDERR.puts params
      params
    end
    File.open(ymlfile, 'w') do |f|
      f.puts data.to_yaml
    end
  end
  
  desc "ymlよみこみ"
  task :import => :environment do
    ActiveRecord::Base.transaction do
      YAML.load_file(ymlfile).each do |params|
        params.delete(:evolution_from_name)
        Monster.create!(params)
        puts params
      end
      YAML.load_file(ymlfile).each do |params|
        Monster.find_by(no: params[:no]).update!(evolution_from: Monster.find_by(name: params[:evolution_from_name]))
      end
    end
  end
end
