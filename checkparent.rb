#!/usr/bin/env ruby

require './checkchild'
require 'open-uri'
require 'nokogiri'

class CheckParent
  def initialize()
  end

  def do(uri)
    begin

      uri = URI.encode(uri)
      uri = URI.parse(uri)
      html = open(uri).read

      html.sub!(/^<!DOCTYPE html(.*)$/, '<!DOCTYPE html>')

      doc  = Nokogiri::HTML(html)

      link = []

      #doc.css('a').each do |anchor|
      #  link.push(anchor[:href])
      #end

      #doc.css('input').each do |anchor|
      #  if s = anchor[:onclick]
      #    s = s[/\'.*\'/]
      #    link.push(s.delete!("'"))
      #  end
      #end

      doc.css('img').each do |anchor|
        link.push(anchor[:src])
      end

      #link.sort!

      check = Check.new()

      res = check.do(uri, link)

      if res.any?
        puts "===================================="
        puts uri
        puts res
        puts "===================================="
      end

    rescue => error
      puts "例外発生"
      puts "#{error.backtrace}"
      puts "[#{self.class.name}][#{error.message}]"
      exit 1
    end
  end
end
