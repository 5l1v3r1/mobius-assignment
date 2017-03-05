.PHONY: test

unit-test:
	rm -rf tests/__pycache__/
	py.test tests -v -s

functional-test:
	rm -rf functional-tests/__pycache__/
	py.test functional-tests -v -s

test:
	make fmt-test
	make unit-test
	make functional-test

dependencies:
	pip install --upgrade -I -r requirements.txt
	pip freeze | grep -v "gurobipy" > requirements.txt

fmt:
	yapf -r -i mobius/ functional-tests/ tests/ || :

fmt-test:
	yapf -r -d mobius/ functional-tests/ tests/ || (echo "Document not formatted - run 'make fmt'" && exit 1)
dev-test:
	make fmt
	make test
dependency-update:
	echo "Updating all packages in requirements.txt"
	pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U

server:
	bash server.sh

tune:
	python -c "from mobius.tuner import tune; tune()"

