#!/usr/bin/env ruby

require './checkparent'
require "csv"

File.open("image_none.csv","w") do |text|
  CSV.foreach("url.csv", headers: true) do |row|
    parent = CheckParent.new()
    parent.do(row["URL"])
    puts "end"
  end
end
