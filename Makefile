.PHONY: d-up d-stop d-down d-restart d-logs d-clean

d-up:
	docker compose up -d


d-stop:
	docker compose stop

d-down:
	docker compose down


d-restart:
	docker compose restart


d-logs:
	docker compose logs -f


d-clean:
	docker rmi $(docker images -a -q)
