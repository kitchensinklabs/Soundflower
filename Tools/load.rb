#!/usr/bin/env ruby -wKU

###################################################################
# build Telephonica, install it, and start it
# installs to /System/Library/Extensions
# requires admin permissions and will ask for your password
###################################################################

#require 'open3'
require 'fileutils'
require 'pathname'
#require 'rexml/document'
#include REXML

# This finds our current directory, to generate an absolute path for the require
libdir = "."
Dir.chdir libdir        # change to libdir so that requires work

@svn_root = ".."

puts "  Unloading and removing existing Telephonica.kext"
if File.exists?("/System/Library/Extensions/Telephonica.kext")
  puts "    first unload (will often fail, but will cause Telephonica's performAudioEngineStop to be called)"
  `sudo kextunload /System/Library/Extensions/Telephonica.kext`
  puts "    second unload (this one should work)"
  `sudo kextunload /System/Library/Extensions/Telephonica.kext`
  puts "    removing"
  puts `sudo rm -rf /System/Library/Extensions/Telephonica.kext`
end

puts "  Copying to /System/Library/Extensions and loading kext"
`sudo cp -rv "#{@svn_root}/Build/Telephonica.kext" /System/Library/Extensions`
`sudo kextload -tv /System/Library/Extensions/Telephonica.kext`
`sudo touch /System/Library/Extensions`

puts "  Done."
puts ""
exit 0
