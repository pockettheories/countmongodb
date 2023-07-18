require 'mongo'
require 'json'
require 'cli/ui'

mongouri = ENV['mongouri'] || 'mongodb://host.docker.internal'
dbname = ENV['dbname'] || 'test'
collname = ENV['collname'] || 'coin'
sleeptime = (ENV['sleeptime'] || 1).to_i

client = Mongo::Client.new mongouri
client = client.use dbname
client[collname].delete_one({_id: 1})

CLI::UI.frame_style= :bracket
CLI::UI::StdoutRouter.enable

puts CLI::UI.fmt("{{green:We only increment the coin-toss counter when we see a head}}")

actual_toss_count = 0

loop do
  val_to_insert = rand(0..1)
  actual_toss_count += 1

  CLI::UI::Frame.open("Tossed a " + (val_to_insert==0 ? 'Tail' : 'Head')) do
  if val_to_insert == 0
    puts CLI::UI.fmt("{{yellow:NO-OP}}")
  else
    puts CLI::UI.fmt "{{green:Executing}}"
    doc = client[collname].find_one_and_update(
      {_id: 1},
      {'$inc': {toss_count: 2}},
      {upsert: true, return_document: :after}
    )
    puts "
  db.#{collname}.updateOne(
    {_id: 1},
    {$inc: {toss_count: 2}},
    {upsert: true}
  );
    "
    puts CLI::UI.fmt "{{green:Output document}}"
    puts ''
    puts JSON.pretty_generate(doc)
  end
  end
  puts CLI::UI.fmt "{{yellow:Actual toss count: #{actual_toss_count}}}"
  puts ''

  sleep sleeptime
end

