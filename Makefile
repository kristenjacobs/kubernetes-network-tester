yaml:
	sed  's/^/          /' test.sh > test.sh.indented
	sed -e '/TEST_SCRIPT/ {' -e 'r test.sh.indented' -e 'd' -e '}' test.yaml.template > test.yaml
	rm -rf test.sh.indented

apply: yaml
	kubectl apply -f test.yaml

delete: yaml
	kubectl delete -f test.yaml
