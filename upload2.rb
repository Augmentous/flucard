#!/mnt/sd/deploy/usr/bin/ruby
# -*- coding: utf-8 -*-
 
require 'net/ftp'
require 'net/http'
require 'uri'

require 'exifr'
include EXIFR
 
# ------------------------------
# user configuration
# ------------------------------
 
#DONE_FILE = "/mnt/sd/FLU/alreadydone.txt"
DONE_FILE = "/tmp/allnewfiles3"
OUT_FILE = "/tmp/outfile" 
FINAL_OUT_FILE = "/mnt/mtd/"

FTP_SERVER = "jjrosent.zrg.cc"
FTP_USER = "zrg"
FTP_PASSWORD = "nAFmkvvbQvMq9GapSn"
FTP_PATH = "/data/uploads_t/zrg/flu"
#LOCAL_PATH = "/mnt/sd/DCIM/"
 
# ------------------------------
# main
# ------------------------------
 

def test_thumbnail
	count = 0
	all_test_jpegs.each do |fname|
	  jpeg = JPEG.new(fname)
	  unless jpeg.thumbnail.nil?
	    assert_nothing_raised 'thumbnail not a JPEG' do
	      JPEG.new(StringIO.new(jpeg.thumbnail))
	    end
	    count += 1
	  end
	end
	assert count > 0, 'no thumbnails found'
end


if !File.exists?(DONE_FILE)
  exit
else
	begin
	    alreadydone = File.read(DONE_FILE).split("\n")
#	    workon = Dir.entries(LOCAL_PATH).delete_if { |x| a.include?(x) || x.include?(".") }
		workon = alreadydone
	    # fulllist = Dir[LOCAL_PATH].each { |file| }
	    ftp = Net::FTP.open(FTP_SERVER, FTP_USER, FTP_PASSWORD)
	    ftp.chdir(FTP_PATH)
	    workon.each do |fname|
			if File.exists?(fname)
				begin
					ftp.putbinaryfile(fname, File.basename(fname))
				    print "#{File.basename(fname)} uploaded."
				    File.open(OUT_FILE, "a") { |f| f.write(File.basename(fname) + "\n")}
				rescue
				    print "Error while ftp put: #{$!}"
	    			exit
			  	end
			end
      	print "All uploads done."
	end
  	rescue
    	print "Error while processing: #{$!}"
  	end
end