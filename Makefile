NAME = liggitt/client-cert
VERSION = 0.1.0

.PHONY: all build test tag_latest release

all: build tag_latest

clean:
	rm server

build:
	go build server.go
	docker build -t $(NAME):$(VERSION) --rm .

test:
	env NAME=$(NAME) VERSION=$(VERSION) ./test/runner.sh

run:
	docker run -p 9443:9443 -ti $(NAME)

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

release: test tag_latest
	@if ! docker images $(NAME) | awk '{ print $$2 }' | grep -q -F $(VERSION); then echo "$(NAME) version $(VERSION) is not yet built. Please run 'make build'"; false; fi
	@if ! head -n 1 Changelog.md | grep -q 'release date'; then echo 'Please note the release date in Changelog.md.' && false; fi
	docker push $(NAME)
	@echo "*** Don't forget to create a tag. git tag rel-$(VERSION) && git push origin rel-$(VERSION)"
