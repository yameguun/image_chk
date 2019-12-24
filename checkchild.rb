#!/usr/bin/env ruby

require 'open-uri'
require 'nokogiri'

class Check
  def initialize()
  end

  def do(parent, child)

    res = 'OK'
    ary = []

    for item in child do
      unless item.nil?
        case item[0]
        when '#'
          puts "ページ内リンク   => #{item}"
        when 'h'
          # 外部リンクなので存在の有無のみ
          res = fetch(item)
          ary << "リンク切れ => #{item}" if res == 'NG'
        end
      end
    end
    ary
  end

  private
  def fetch(url)

    begin
      uri = URI.encode(url)
      uri = URI.parse(uri)

      open(uri)

    rescue OpenURI::HTTPError => error
      return 'NG'

    rescue => error
      puts "例外発生"
      puts "#{error.backtrace}"
      puts "[#{self.class.name}][#{error.message}]"
      #exit 1
    end

    return 'OK'
  end
end
