# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(email: "oklaiss@smu.edu", password: "password", name: "Owen", role: "admin")
User.create(email: "sbock@smu.edu", password: "password", name: "Steven", role: "admin")
User.create(email: "robertsn@smu.edu", password: "password", name: "Nick", role: "admin")
User.create(email: "contractor@smu.edu", password: "password", name: "Contractor1", role: "contractor")
# Api.create(name: "api1", api_s3_name: "sample.html")
Organization.create(name: "TestOrganization1", code: 11111, owner_id: 1, aws_key: "12345", aws_secret: "12345", bucket_name: "bucket1", region: "us-west-1")