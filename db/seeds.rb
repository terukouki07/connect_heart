# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#管理者(Admin)に権限を付与する
Admin.create!(
	email: 'ConnectHeart@gmail.com',
	password: 'ConnectHeart'
)

# Tag.create([
#     { name: '里親募集中' },
#     { name: 'トライアル中' },
#     { name: '里親様決定'},
#     { name: '迷子捜索中'},
#     { name: '飼育の知恵'},
# ])