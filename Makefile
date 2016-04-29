VERSION = latest
IMAGE = 3cola/mongo

all: image publish

image:
	docker build -t $(IMAGE):$(VERSION) --no-cache .

publish:
	docker push $(IMAGE):$(VERSION)
