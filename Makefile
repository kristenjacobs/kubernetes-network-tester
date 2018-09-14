yaml:
	sed  's/^/          /' test-connectivity.sh > test-connectivity.sh.indented
	sed  's/^/          /' test-dns.sh > test-dns.sh.indented
	cat test.yaml.template | \
		sed -e '/TEST_SCRIPT_CONNECTIVITY/ {' -e 'r test-connectivity.sh.indented' -e 'd' -e '}' | \
		sed -e '/TEST_SCRIPT_DNS/ {' -e 'r test-dns.sh.indented' -e 'd' -e '}' \
		> test.yaml
	rm -rf test-connectivity.sh.indented
	rm -rf test-dns.sh.indented

apply: yaml
	kubectl apply -f test.yaml

delete: yaml
	kubectl delete -f test.yaml
