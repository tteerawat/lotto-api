deploy:
	git push heroku master
	heroku run "POOL_SIZE=2 mix ecto.migrate"

.PHONY: deploy