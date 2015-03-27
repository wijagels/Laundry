#!/usr/bin/ruby

require 'csv'

log = Hash.new
CSV.foreach("./log.csv") do |row|
  if log[row[0]] == nil
    log[row[0]] = []
  end
  log[row[0]].push(row[1...4])
end

puts log
