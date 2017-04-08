def next_page_link
  link = @doc.css('.pager-next')
  if link.length > 0
    HOST + link.children.first['href']
  end
end

def next_page_link?
  next_page_link.present?
end

def extract_project_data(project_url)
  url = HOST + project_url
  project_doc = Nokogiri::HTML(open(url))
  name = project_doc.css("h2").text
  project = project_doc.css(".leader_proyecto").first
  who = project.css("h3").first.text
  program = project.css("p")[0].children.last.text.strip rescue ""
  amount = project.css("p")[1].children.last.text.strip rescue ""
  subsidy = project.css("p")[2].children.last.text.strip rescue ""
  place = project.css("p")[3].children.last.text.strip rescue ""
  return {
    name: name,
    who: who,
    amount: amount,
    subsidy: subsidy,
    place: place
  }
rescue
  debugger; puts
end
