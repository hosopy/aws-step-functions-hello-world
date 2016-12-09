require 'bundler'
Bundler.require
require 'logger'

logger = Logger.new(STDOUT)

activity_arn = ARGV[0]
client = Aws::States::Client.new

loop do
  logger.info('Waiting for a task to start. Press Ctrl-C to interrupt.')
  resp = client.get_activity_task({ activity_arn: activity_arn })

  logger.info("Get activity task : #{resp.inspect}")

  task_token = resp.task_token
  input      = resp.input

  begin
    input = JSON.parse(resp.input)

    # Input check
    unless input.has_key?('who')
      client.send_task_failure({
        task_token: task_token,
        cause:      'Input error'
      })
      logger.error('Input error')
    end

    # Success
    client.send_task_success({
      task_token: resp.task_token,
      output:     JSON.generate({ message: "Hello #{input['who'].to_s}!" })
    })
    logger.info('Success')
  rescue => err
    # Unexpected error
    client.send_task_failure({
      task_token: task_token,
      cause:      'Unexpected error'
    })
    logger.fatal('Unexpected error')
    logger.fatal(err)
  end
end

