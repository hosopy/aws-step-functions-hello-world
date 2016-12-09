# AWS Step Functions Activity Sample

This is a sample ruby implementation of AWS Step Functions Activity.

# How to run worker

```sh
$ git clone https://github.com/hosopy/aws-step-functions-hello-world
$ cd aws-step-functions-hello-world
$ bundle install
$ bundle exec ruby main.rb ${ACTIVITY_ARN}
```

# Activity spec

## Input

* Input JSON must have key `who` whose type is string.

```json
{
  "who": "hoge"
}
```

## Output

* Output JSON has key `message` whose type is string.

```json
{
  "message": "Hello ${who}!"
}
```

If an input is `{ "who": "hoge" }`, output is

```json
{
  "message": "Hello hoge!"
}
```

