set :output, 'log/vatican_indexer.log'

# EC2 servers default to UTC. 10:00 PM UTC = 3:00 PM PST
every :day, at: '10:00 pm' do
  rake 'colligo:vatican'
end
