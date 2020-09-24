BUILDDIR=$(shell pwd)/build
IMPORT_PATH= \
	github.com/frainzy1477/trojan-go-libs/clash \
	github.com/frainzy1477/trojan-go-libs/tun2socks \
	github.com/frainzy1477/trojan-go-libs/freeport \
	github.com/frainzy1477/trojan-go-libs/util \
	github.com/frainzy1477/trojan-go-libs/trojan

# pass a single dollar sign to shell
CURRENT_GOPATH="$(shell echo $$GOPATH)"
CURRENT_WORKDIR="$(shell pwd)"

all: ios android

ios: clean
	mkdir -p $(BUILDDIR)
	gomobile bind -o $(BUILDDIR)/golibs.framework -a -ldflags '-w' -target=ios $(IMPORT_PATH)


android: clean
	mkdir -p $(BUILDDIR)
	env GO111MODULE="on" gomobile bind -o $(BUILDDIR)/golibs.aar -a -v -x -ldflags '-w' -target=android  -gcflags=-trimpath=$(CURRENT_GOPATH) -gcflags=-trimpath=$(CURRENT_WORKDIR) $(IMPORT_PATH)

clean:
	gomobile clean
	rm -rf $(BUILDDIR)

cleanmodcache:
	go clean -modcache
