class CreateEntertainmentNewsJob < ApplicationJob 
 
  require 'open-uri'
  def perform(*args)
  page = Nokogiri::HTML(open('https://news.google.com/news/headlines/section/topic/ENTERTAINMENT'))


    @title = page.xpath('//*[@id="yDmH0d"]/c-wiz/div/div[2]/main/div[1]/c-wiz/div/c-wiz[1]/c-wiz/div/div[2]/c-wiz/a').text


    @source = page.xpath('//*[@id="yDmH0d"]/c-wiz/div/div[2]/main/div[1]/c-wiz/div/c-wiz[1]/c-wiz/div/div[2]/c-wiz/div/span[1]').text
    
    
    @title_url = page.css('#yDmH0d > c-wiz > div > div.fWwQIb.ChVoCd.rOrCPc.AfWyGd > main > div.KaRWed.XogBlf > c-wiz > div > c-wiz.PaqQNc.QwxBBf.f2t20b.PBWx0c > c-wiz > div > div.v4IxVd > c-wiz > a').attr('href')
    
    @image_url = page.css('#yDmH0d > c-wiz > div > div.fWwQIb.ChVoCd.rOrCPc.AfWyGd > main > div.KaRWed.XogBlf > c-wiz > div > c-wiz.PaqQNc.QwxBBf.f2t20b.PBWx0c > c-wiz > div > div.X20oP > a > img').attr('src')
    
    entertainment = Entertainment.new
    entertainment.title = @title
    entertainment.source = @source 
    entertainment.title_url = @title_url
    entertainment.image_url = @image_url

     
    entertainment.save


  end
end 
