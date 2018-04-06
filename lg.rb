require 'rubygems'

infile = ARGV[0]

lines = File.read(infile).lines
pages = Array.new()

lines.each do |line|
  if line=~/--- needs --- report.idv\[(.*?)\] ==>/ then
    pages << $1
  end
end

s = ""
sep = ""
prev = 0
j = 0
k = ""
pages.each do |i|
  k = k + "," + i.to_s
  j = j + 1
  if j == 20 then
    s = "#{s}#{sep}#{i}"
    puts k
    puts s
    exit
  end
  if  i.to_i == prev+1 then
    sep = "-"
    prev = i.to_i
    next
  else
    if prev != 0 then
      s = "#{s}#{sep}#{prev}"
      sep = ","
    end
  end
  sep = "" if j == 1
  s = "#{s}#{sep}#{i}"
  prev = i.to_i
end
#s = "#{s}#{sep}#{prev}"
puts s

#puts  pages.join(",")
