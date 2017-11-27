#makefile
SHELL := /bin/bash

install:
	pip install -r requirements.txt

test-unit-nose:
	coverage erase ;\
	nose2 -v --with-coverage ;\
	coverage report -m ;\

test-unit-pytest:
	coverage erase ;\
	py.test --cov . --cov-report=term -v ;\
	coverage report -m ;\

test-coverage:
	coverage erase ;\
	coverage run -m task_list_dev.__main__ -v ;\
	coverage report -m ;\

all-tests: test-unit-nose test-unit-pytest test-coverage

clean-build:
	@rm -rf build/ dist/ .eggs/ *.egg-info/ .tox/ .coverage cover/ htmlcov/ html/ doctrees/ .cache/

clean:
	@find . -name "*.pyc" | xargs rm -f

clean-all: clean clean-build

doc:
	@sphinx-build -E -W -c docs/source/ -b html docs/source/ docs/build/html

devtest:
	pytest-watch