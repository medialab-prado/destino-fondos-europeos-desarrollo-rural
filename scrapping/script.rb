require 'rubygems'
require 'bundler'
Bundler.require
require 'byebug'
require 'uri'
require 'open-uri'
require 'net/http'
require 'active_support/all'
require 'csv'

require_relative './utils'

URL = "http://www.adri.es/programa-leader/programa-leader-2007-2013/historico-proyectos/resultados-de-busqueda"
HOST = "http://" + URI.parse(URL).host

data = []

@doc = Nokogiri::HTML(open(URL))

while next_page_link?
  projects = @doc.css('.leader_proyecto')
  projects.each do |project|
    project_link = project.children[1].children[0]['href']
    project_data = extract_project_data(project_link)
    data.push(project_data)
  end

  @doc = Nokogiri::HTML(open(next_page_link))
end

projects = @doc.css('.leader_proyecto')
projects.each do |project|
  project_link = project.children[1].children[0]['href']
  project_data = extract_project_data(project_link)
  data.push(project_data)
end

CSV.open("datos.csv", "wb") do |csv|
  csv << ["nombre", "institucion", "cantidad", "subvencion", "municipio"]
  data.each do |project|
    csv << [project[:name], project[:who], project[:amount], project[:subsidy], project[:place]]
  end
end
