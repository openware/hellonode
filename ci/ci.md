# Concourse CI pipeline config

## Deploy

Go to the CI site
```
https://ci.devstack.work/
```

Download CLI tools

Log in to a team
```
fly --target helios login --team-name main \
    --concourse-url https://ci.devstack.work
```

Set pipeline
```
# credentials.yml should contain gcr credentials
fly -t helios set-pipeline -p hellonode -c ci/pipeline.yml -l ci/credentials.yml
```

Unpause pipeline
```
fly -t helios unpause-pipeline -p hellonode
```

Trigger job
```
fly -t helios trigger-job -j hellonode/hellonode
```

Go to https://ci.devstack.work/teams/main/pipelines/hellonode
