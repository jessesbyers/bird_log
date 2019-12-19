user_list = [
  [ "Jesse", "jesse@email.com", "jessepw"],
  [ "Mike", "mike@email.com", "mikepw"],
  [ "Ryan", "ryan@email.com", "ryanpw"],
  [ "Griffin", "griffin@email.com", "griffinpw"],
  [ "Pepper", "pepper@email.com", "pepperpw"],
]

user_list.each do |username, email, password|
  User.create(username: username, email: email, password: password)
end



Bird.create(Bird.scrape_attributes("https://www.audubon.org/field-guide/bird/bald-eagle"))
Bird.create(Bird.scrape_attributes("https://www.audubon.org/field-guide/bird/black-chinned-hummingbird"))



sighting_list = [
  ["https://www.audubon.org/field-guide/bird/bald-eagle", "01/11/2017", "Back yard", "Soaring overhead", "1", "1"],
  ["https://www.audubon.org/field-guide/bird/bald-eagle", "05/18/2017", "Front yard", "Flying south", "2", "1"],
  ["https://www.audubon.org/field-guide/bird/bald-eagle", "01/20/2019", "Bay Park", "Sitting on dead tree branch", "3", "1"],
  ["https://www.audubon.org/field-guide/bird/black-chinned-hummingbird", "08/11/2017", "Front garden", "sipping nectar", "4", "2"],
  ["https://www.audubon.org/field-guide/bird/black-chinned-hummingbird", "07/02/2017", "Day Lily patch", "2 birds observed feeding", "5", "2"],
  ["https://www.audubon.org/field-guide/bird/black-chinned-hummingbird", "01/30/2018", "Back deck", "3 birds at feeder", "1", "2"],
  ["https://www.audubon.org/field-guide/bird/bald-eagle", "05/18/2017", "Kamp Kill Kare", "Sitting on dead tree branch", "2", "1"],
  ["https://www.audubon.org/field-guide/bird/black-chinned-hummingbird", "04/18/2019", "Front porch", "At hummingbird feeder", "1", "2"]
]

sighting_list.each do |audubon_url, date, location, notes, user_id, bird_id|
  Sighting.create(audubon_url: audubon_url, date: date, location: location, notes: notes, user_id: user_id, bird_id: bird_id)
end
