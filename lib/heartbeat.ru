require 'yaml'

run lambda { |_env|
  [
    200,
    { 'Content-Type' => 'text/plain' },
    [_env.to_yaml]
  ]
}
