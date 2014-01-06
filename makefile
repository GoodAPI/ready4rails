.PHONY: test

gems:
		which gs  || gem install gs
		which dep || gem install dep
		gs init

install:
		dep install

seed:
		env $$(cat env.sh) ruby seeds.rb

server:
		env $$(cat env.sh) shotgun -o 0.0.0.0

console:
		env $$(cat env.sh) pry -r ./app.rb

test:
		env $$(cat env.sh) cutest test/**/*.rb
