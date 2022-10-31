#ユーザー作成
[{
    id: 1,
    username: 'testuser_1',
    password: 'password'
}].each do |value|
  default_user = User.find_or_create_by(id: value[:id])
  default_user.assign_attributes(
    username: value[:username],
    password: value[:password]
  )
  default_user.save!
end