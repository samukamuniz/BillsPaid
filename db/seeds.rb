# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Cadastrando Administrador Padrão.."
	Admin.create!(name: "Adm Padrão",
								email: "admin@billspaid.com",
								password: "123456",
								password_confirmation: "123456",
								role: 0)
puts "Admin cadastrado com sucesso!"

puts "Cadastrando Usuário Padrão.."
	Member.create!(email: "samuka@billspaid.com",
								password: "123456",
								password_confirmation: "123456")
puts "Usuário cadastrado com sucesso!"

puts "Gerando Contas"
	Account.create(description: "Carteira", amount: 230.45, member_id: 1)
	Account.create(description: "Bradesco", amount: 1038.69, member_id: 1)
puts "Contas gerados"

#puts "Gerando Tipos de transações"
#	KindTransaction.find_or_create_by(description: "Despesas")
#	KindTransaction.find_or_create_by(description: "Receitas")
#puts "Tipos de transações gerados"

puts "Gerando Categorias"
	Category.find_or_create_by(description: "Alimentação", kind_transaction: 1, member_id: 1)
	Category.find_or_create_by(description: "Educação", kind_transaction: 1, member_id: 1)
	Category.find_or_create_by(description: "Saúde", kind_transaction: 1, member_id: 1)
	Category.find_or_create_by(description: "Diversão", kind_transaction: 1, member_id: 1)
	Category.find_or_create_by(description: "Salário", kind_transaction: 2, member_id: 1)
	Category.find_or_create_by(description: "Freelancer", kind_transaction: 2, member_id: 1)
puts "Categorias geradas"

puts "Gerando Transações"
	Transaction.create(kind_transaction_id: 1,description: "Merenda",amount: 5.49,
		date: "2017.04.20",category_id: 1,account_id: 1,paid: true)
	
	Transaction.create(kind_transaction_id: 1,description: "Remedio",amount: 25.37,
		date: "2017.04.23",category_id: 3,account_id: 2,paid: true)
	
	Transaction.create(kind_transaction_id: 2,description: "Salario",amount: 309.45,
		date: "2017.04.30",category_id: 1,account_id: 2,paid: true)
	
	Transaction.create(kind_transaction_id: 2,description: "Freela TI",amount: 70.01,
		date: "2017.05.01",category_id: 6,account_id: 1,paid: true)
puts "Transações geradas"