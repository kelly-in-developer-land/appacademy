User.destroy_all
Contact.destroy_all
ContactShare.destroy_all
#
u1 = User.create!(username: "User1")
u2 = User.create!(username: "User2")
c1 = u1.contacts.create!(name: "Contact1", email: "contact1@example.com")
c2 = u1.contacts.create!(name: "Contact2", email: "contact2@example.com")
c3 = u2.contacts.create!(name: "Contact3", email: "contact3@example.com")

uid = u2.id
cid = c2.id
ContactShare.create!(user_id: uid, contact_id: cid)
