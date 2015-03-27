#!/usr/bin/env ruby

require 'csv'
require 'gruff'

##
# The first row of the csv is used as the keys to the hash.
# The remainder of the csv row is inserted as an array of arrays in the
# corresponding value positions in the hash.
##

log = Hash.new
CSV.foreach("./log.csv") do |row|
  if log[row[0]] == nil
    log[row[0]] = []
  end
  log[row[0]].push(row[1..log.size])
end

#puts log

g = Gruff::Line.new(4000)
g.title = 'Broome Dryers in use'

labels = Hash.new
log['BroomeDryers'].each_with_index{|val, index| labels[index] = val[0]} 
#puts labels

data = Array.new
#puts log['BroomeDryers'][0]
log['BroomeDryers'].each_with_index{|val, index| data[index] = val[2].to_i - val[1].to_i}

#newdata = Hash[*data.sort_by {|k,v| k}[1..31].flatten]
newdata = data[1..100]

p newdata

g.labels = {
  0 => ""
}

g.data("In use", newdata) 
g.write('output.png')

