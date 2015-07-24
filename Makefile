image=tmaczukin/http-router

test: build run

build:
	docker build --rm -t $(image):latest .

run_command=bash
run:
	docker run --rm -t -i -v $(shell pwd):/usr/local/lib/http-router/ $(image):latest $(run_command)
