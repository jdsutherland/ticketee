unless User.exists?(email: "admin@ticketee.com")
  User.create!(email: "admin@ticketee.com", password: 'password', admin: true)
end

unless State.exists?
  State.create(name: 'New',     color: '#0066cc', default: true)
  State.create(name: 'Open',    color: '#008000')
  State.create(name: 'Closed',  color: '#990000')
  State.create(name: 'Awesome', color: '#663399')
end
