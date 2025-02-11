# Calendar App
![CI](https://github.com/gnublet/calendar_app/actions/workflows/test.yaml/badge.svg)

## Setup
Copy `.env.test` as `.env` and customize your environment variables as desired, then choose your preferred method from the choices below:

### With docker compose
```
docker compose up
```

### Without docker
(Optional) Create a virtual environment
```
python -m venv .venv
```
Install python packages
```
pip install -r requirements/base.txt
pip install -r requirements/test.txt
```

Set up a postgres database through a method of your choice
Create alembic environment
```
alembic init alembic
```
Start migrations
```
alembic upgrade head
```
To run:
```
fastapi run app/main.py --port 8000
```


For tests to work, we create a setup.py file and install in development mode:
```
pip install -e .
```
then run 
```
pytest -v tests
```

### With kubernetes
Assuming you have Kubernetes installed (If you don't, you can use [k3s](https://docs.k3s.io/quick-start))

Install CloudNativePG
```
kubectl apply --server-side -f \
  https://raw.githubusercontent.com/cloudnative-pg/cloudnative-pg/release-1.25/releases/cnpg-1.25.0.yaml
```

Install Atlas for kubernetes based database migrations
```
helm install atlas-operator oci://ghcr.io/ariga/charts/atlas-operator
```

Then install the kubernetes manifests
```
kubectl apply -f terraform/manifests/.
```

## Contributing
To build and push to a github container registry, first get a [PAT token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens) from Github
```
export CR_PAT=YOUR_TOKEN
echo $CR_PAT | docker login ghcr.io -u USERNAME --password-stdin
docker build -t ghcr.io/gnublet/calendar_app:0.1 .
docker build -t ghcr.io/gnublet/calendar_app_test:0.1 --target test .
docker build -t ghcr.io/gnublet/calendar_app:0.1 --target prod .
docker push ghcr.io/gnublet/calendar_app_test:0.1
docker push ghcr.io/gnublet/calendar_app:0.1
```

And you can view the user's packages here: https://github.com/gnublet?tab=packages
If you want to share it, you have to make the package public (it's private by default)