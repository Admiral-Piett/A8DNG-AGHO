# A8DNG-AGHO

## To Run
### Environment
All the environment variables for this app are pre-populated in `app-variables.env`.  If we need to change them for
any reason update them there and re-install or rebuild (depending on your choice).
### Native (Unix/Linux Only)
#### Pre-Requisite: pyenv - https://github.com/pyenv/pyenv#installation
- Clone repo
- Make sure `NOCLIST_DOMAIN=http://localhost:8888` (or intended noclist host) in `app-variables.env`.
- Run the following:
```shell
cd A8DNG-AGHO
./install.sh
source venv/bin/activate
python src/app.py
```
#### What This Does
Using the `pyenv` library this will create an environment in a directory called `./venv`.  It will populate it with all
the requirements of this app, and all the required environment variables from `app-variables.env` (changes to
`app-variables.env` will require another run of `./install.sh` to take effect).

### Docker
- Clone repo
- Make sure `NOCLIST_DOMAIN=http://host.docker.internal:8888` to allow docker to reach your local host, or replace
  with intended noclist host `app-variables.env`.
- Run the following:
```shell
cd A8DNG-AGHO
docker build --no-cache -t cfsb-test .
docker run --rm --env-file app-variables.env cfsb-test
```

## To Run Tests
### Native
- Clone repo
- Run the following:
```shell
cd A8DNG-AGHO
./install.sh
source venv/bin/activate
pytest
```
### Docker
- Clone repo
- Run the following:
```shell
cd A8DNG-AGHO
docker build --no-cache -t cfsb-test --target test .
docker run -it --rm cfsb-test
```
